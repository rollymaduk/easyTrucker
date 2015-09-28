updateSchedule=(qry,modifier,options)->
  Schedules.update(qry,modifier,options)

Meteor.methods
  addUpdateSchedule:(schedule)->
    schedule.pickupLocation.geometry.loc=
      GeoDataHelper.createPointGeoJSON(schedule.pickupLocation.geometry.lng,schedule.pickupLocation.geometry.lat)

    schedule.dropOffLocation.geometry.loc=
      GeoDataHelper.createPointGeoJSON(schedule.dropOffLocation.geometry.lng,schedule.dropOffLocation.geometry.lat)

    distFromPickup=GeoJSON.pointDistance(schedule.pickupLocation.geometry.loc,schedule.dropOffLocation.geometry.loc)

    schedule.shipmentDistance=distFromPickup

    Schema.TruckSpecs.clean(schedule.specs)

    truckqry=TruckHelpers.getTruckSpecsQuery(schedule.specs)
    truckqry=_.extend(truckqry,{$or:['dropoffSettings.coverage':$in:['international','usa']
    ,{'dropoffSettings.coverageDistance.value':$gte:distFromPickup}
    ,{'pickupSettings.coverage':$in:['international','usa']}]})

    trucks=Trucks.find(truckqry).map (doc)->
      baseDist=doc.pickupSettings?.coverageDistance?.value
      if baseDist
        dist=GeoJSON.pointDistance(doc.baseLocation.geometry.loc,schedule.pickupLocation.geometry.loc)
        if dist<=baseDist
          _.pick(doc,'_id','owner')
      else
        _.pick(doc,'_id','owner')

    truckers=_.map(_.groupBy(trucks,'owner'),(val,key)->
      trucks=_.map(val,(doc)->
        doc._id
      )
      {owner:key,trucks:trucks}
    )
    schedule.truckers=truckers
    schedule.wayBill="EZT-#{new Date().getTime()}"
    service= new TransactionService()
    service.addUpdateSchedule(schedule)

  searchSchedules:(pipeline)->
    Schedules.aggregate(pipeline)

  addScheduleComment:(schedule,comment)->
    Form.Message.clean(comment)
    Schedules.update(schedule,$addToSet:messages:comment)

  acceptScheduleBid:(schedule,wB)->
    check(schedule,String)
    check(wB,{bidder:String,bid:String})
    Schedules.update(schedule,{$set:{'winningBid.bidder':wB.bidder,'winningBid.bid':wB.bid,status:STATE_BOOKED,nextStep:STATE_ASSIGNED}})

  assignResource:(resource,schedule)->
    check(resource,{driver:String,truck:String})
    Schedules.update(schedule,{$set:{resource:resource,status:STATE_ASSIGNED,nextStep:STATE_DISPATCH}})

  updateSchedule:(qry,modifier,options)->
    updateSchedule(qry,modifier,options)

  removeSchedule:(schedule)->
    item=Schedules.findOne(schedule)
    messages=Messages.find({documentId:schedule}).map (doc)->doc._id
    activities=Activities.find({documentId:schedule}).map (doc)->doc._id
    if item
      Activities.remove({documentId:schedule})
      Messages.remove({documentId:schedule})
      Bids.remove({schedule:schedule})
      eZFiles.remove({_id:$in:item.files})  if item.files
      Dispatches.remove({schedule:schedule})
      Notifications.remove({documentId:$in:messages})
      Notifications.remove({documentId:$in:activities})
      Schedules.remove(schedule)

  duplicateSchedule:(schedule)->
    item=Schedules.findOne(schedule)
    if item
      Meteor.call('addUpdateSchedule',_.omit(item,['updatedAt','createdAt'
      ,'updatedBy','createdBy','winningBid','isLate','_id','bidders','messages','totalBids','resource',
        'status','wayBill','nextStep'
      ]))

  checkAndUpdateLateSchedules:()->
    late=[];cancel=[];
    Schedules.find({status:{$nin:[STATE_CANCELLED,STATE_LATE,STATE_SUCCESS,STATE_ISSUE]},$or:[
      {$and:[{'pickupDate.dateField_2':$lte:new Date()},{'pickupDate.context':'between'}]}
      {$and:[{'pickupDate.dateField_1':$lte:new Date()},{'pickupDate.context':$ne:'between'}]}
      {$and:[{'dropOffDate.dateField_2':$lte:new Date()},{'dropOffDate.context':'between'}]}
      {$and:[{'dropOffDate.dateField_1':$lte:new Date()},{'dropOffDate.context':$ne:'between'}]}
    ]}).forEach (doc)->
      switch doc.status
        when STATE_NEW then cancel.push(doc._id)
        else late.push(doc._id)
    Schedules.update({_id:$in:cancel},$set:{status:STATE_CANCELLED},{multi:true}) if cancel.length
    Schedules.update({_id:$in:late},$set:{status:STATE_LATE,isLate:true},{multi:true}) if late.length
    late.length+cancel.length


