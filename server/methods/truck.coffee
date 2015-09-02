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
    truck.baseLocation.geometry.loc=
      GeoDataHelper.createPointGeoJSON(truck.baseLocation.geometry.lng,truck.baseLocation.geometry.lat)
    cloned=_.extend({},truck)
    Schema.TruckSpecs.clean(cloned)
    radius=truck.pickupSettings?.coverageDistance?.value
    distance=truck.dropoffSettings?.coverageDistance?.value
    truck_qry=TruckHelpers.buildTruckMatchQuery(cloned,'specs.'
    ,true,truck.baseLocation.geometry.loc.coordinates,radius,distance)
    schedules=Schedules.find(truck_qry).map (doc)->
      doc._id
    _truckId=truck._id
    unless truck._id
      _truckId=Trucks.insert truck
    else
      Trucks.update truck._id,{$set:truck}
    updateScheduleTrucker(schedules,Meteor.userId(),_truckId)
    _truckId



  searchTrucks:(pipeline)->
    Trucks.aggregate(pipeline)

