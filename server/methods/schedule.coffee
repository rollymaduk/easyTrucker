updateSchedule=(qry,modifier,options)->
  Schedules.update(qry,modifier,options)

Meteor.methods
  addUpdateSchedule:(schedule)->
    @unblock()
    ###check for request status before an update###
    if schedule.totalBids > 0
      return
    else
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
    @unblock()
    Schedules.aggregate(pipeline)

  acceptScheduleBid:(schedule,wB)->
    @unblock()
    check(schedule,String)
    check(wB,{bidder:String,bid:String})
    Schedules.update(schedule,{$set:{'winningBid.bidder':wB.bidder,'winningBid.bid':wB.bid,status:STATE_BOOKED,nextStep:STATE_ASSIGNED}})

  assignResource:(resource,schedule)->
    @unblock()
    check(resource,{driver:String,truck:String})
    Schedules.update(schedule,{$set:{resource:resource,status:STATE_ASSIGNED,nextStep:STATE_DISPATCH}})

  updateSchedule:(qry,modifier,options)->
    @unblock()
    updateSchedule(qry,modifier,options)

  cancelSchedule:(schedule)->
    @unblock()
    item=Schedules.findOne(schedule)
    states=NON_CANCEL_STATES
    unless _.contains(states,item.status)
      updateSchedule(schedule,$set:{status:STATE_CANCELLED})


  duplicateSchedule:(schedule,doc)->
    @unblock()
    item=Schedules.findOne(schedule)
    if doc then _.extend(item,doc)
    if item
     Meteor.call('addUpdateSchedule',_.omit(item,['updatedAt','createdAt'
      ,'updatedBy','createdBy','winningBid','isLate','_id','bidders','messages','totalBids','resource',
                                                   'status','wayBill','nextStep','charge','memo','delivery','dispatch'
      ]))

  checkAndSendReminders:(refDate)->
    @unblock()
    reminders=Schedules.find({nextStep:$in:[STATE_EXPIRE,STATE_DISPATCH,STATE_SUCCESS]}).map (schedule)->
      data=Eztrucker.Utils.Notification.getRequestReminderMessage(schedule,refDate)
      users=Eztrucker.Utils.Notification.getRequestReminderAudience(schedule)
      users=Meteor.users.find(_id:$in:users).fetch()
      acceptedBid=Bids.findOne({'schedule._id':schedule._id})
      baselineDate=Eztrucker.Utils.Notification.getBaselineDate(schedule.nextStep,acceptedBid)
      addresses=Eztrucker.Utils.Notification.filterUsersByReminderSettings(users,baselineDate)
      {addresses:addresses,data:data}
    _.each(reminders,(reminder)->
      if reminder.addresses.length
        emailObjs=Rp_swu_mailer.createMailItems(TEMPLATE_REMINDER,reminder.addresses,reminder.data)
        Rp_swu_mailer.send(emailObjs)
    )
    reminders.length


  checkAndUpdateLateSchedules:()->
    @unblock()
    late=[];cancel=[];
    Schedules.find({status:{$nin:[STATE_EXPIRE,STATE_CANCELLED,STATE_LATE,STATE_SUCCESS,STATE_ISSUE]},$or:[
      {$and:[{'pickupDate.dateField_2':$lte:new Date()},{'pickupDate.context':'between'}]}
      {$and:[{'pickupDate.dateField_1':$lte:new Date()},{'pickupDate.context':$ne:'between'}]}
      {$and:[{'dropOffDate.dateField_2':$lte:new Date()},{'dropOffDate.context':'between'}]}
      {$and:[{'dropOffDate.dateField_1':$lte:new Date()},{'dropOffDate.context':$ne:'between'}]}
    ]}).forEach (doc)->
      switch doc.status
        when STATE_NEW then cancel.push(doc._id)
        else late.push(doc._id)
    Schedules.update({_id:$in:cancel},$set:{status:STATE_EXPIRE,nextStep:STATE_CLOSED},{multi:true}) if cancel.length
    Schedules.update({_id:$in:late},$set:{status:STATE_LATE,isLate:true},{multi:true}) if late.length
    late.length+cancel.length

  dispatchLoad:(dispatch)->
    @unblock()
    Schedules.update(dispatch.schedule,$set:{dispatch:dispatch,status:STATE_DISPATCH,nextStep:STATE_SUCCESS})


  deliverLoad:(delivery)->
    @unblock()
    status=if delivery.hasIssue then STATE_ISSUE else STATE_SUCCESS
    Schedules.update(delivery.schedule,$set:{delivery:delivery,status:status,nextStep:STATE_CLOSED})