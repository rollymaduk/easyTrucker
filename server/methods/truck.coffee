updateScheduleTrucker=(schedules,trucker,truck)->
    if schedules.length
      isUpdate=Schedules.update({_id:{$in:schedules},'truckers.owner':trucker},
        {$addToSet:'truckers.$.trucks':truck},multi:true)
      console.log isUpdate
      unless isUpdate
        console.log 'update 2'
        Schedules.update({_id:{$in:schedules},'trucker.owner':$ne:trucker}
        ,{$addToSet:truckers:{owner:trucker,trucks:[truck]}},multi:true)
    else
      Schedules.update({'truckers.owner':trucker},{$pull:{'truckers.$.trucks':truck}},multi:true)
      Schedules.update({'truckers.owner':trucker,'truckers.trucks':$size:0}
      ,{$pull:{truckers:owner:trucker}},multi:true)




Meteor.methods
  addUpdateTruck:(truck)->
    truck=if _.isString(truck) then Trucks.findOne(truck,{fields:{updatedAt:0,updatedBy:0,createdBy:0,createdAt:0}}) else truck
    truck=_.omit(truck,'_id')
    check(@userId,String)
    @unblock()
    truck.baseLocation.geometry.loc=
      GeoDataHelper.createPointGeoJSON(truck.baseLocation.geometry.lng,truck.baseLocation.geometry.lat)
    cloned=_.omit(_.extend({},truck),"type","typeId")
    Schema.TruckSpecs.clean(cloned)
    radius=truck.pickupSettings?.coverageDistance?.value
    distance=truck.dropoffSettings?.coverageDistance?.value
    truck_qry=TruckHelpers.buildTruckMatchQuery(cloned,'specs.'
    ,true,truck.baseLocation.geometry.loc.coordinates,radius,distance)
    console.log truck_qry
    schedules=Schedules.find(truck_qry).map (doc)->
      doc._id
    console.log schedules
    _truckId=truck._id
    unless truck._id
      _truckId=Trucks.insert truck
    else
      Trucks.update truck._id,{$set:truck}
    updateScheduleTrucker(schedules,Meteor.userId(),_truckId)
    _truckId

  checkAndUpdatePolicyValidity:()->
   invalidPolicies= Trucks.find({isPolicyValid:$ne:false}).map (doc)->
     if Date()>doc.policyDate then doc._id else null
   Trucks.update({_id:$in:_.compact(invalidPolicies)},{$set:isPolicyValid:false})


  searchTrucks:(pipeline)->
    check(@userId,String)
    check(pipeline,Object)
    @unblock()
    Trucks.aggregate(pipeline)

  removeTruck:(truck)->
    check(@userId,String)
    check(truck,Match.OneOf(String,Object))
    @unblock()
    id=if _.isObject(truck) then truck._id else truck
    Trucks.remove({_id:id})

