getCoverageDescription=(coverage,value,metric,label)->
  value=Converters.convertDistanceFromMeter(value,metric)
  switch coverage
    when 'distance' then "#{value} #{metric} from #{label}"
    else coverage


Trucks.helpers
  title:()->
    item="#{@type} #{@registration}"
    item.trimToLength(15)
  insurance:()->
    "#{@InsuranceCompany} (#{@policyNumber})"

  drivers:->
    busyDrivers=Schedules.find({status:$in:[STATE_ASSIGNED,STATE_DISPATCH]}).map (doc)->doc.resource.driver
    drivers=Roles.getUsersInRole(ROLE_DRIVER,Meteor.user().username).map (doc)->
      doc.userProfile() if !_.contains(busyDrivers,doc._id)
    _.compact(drivers)



  matches:->
    Schedules.find({status:{$in:[STATE_NEW,STATE_BOOKED]},'truckers.trucks':$in:[@_id]}).map (doc)->
      doc._id

  schedule:->
    res=Schedules.find({status:{$in:[STATE_ASSIGNED,STATE_DISPATCH]},'truckers.trucks':$in:[@_id]}).map (doc)->
      {id:doc._id,title:"#{doc.shipmentTitle} - #{doc.wayBill}"
        ,start:doc.bid().proposedPickup.dateField_1,end:doc.bid().proposedDelivery.dateField_2 or doc.bid().proposedDelivery.dateField_1}
    accepted=Session.get('acceptedRequestItem')
    console.log accepted
    if accepted
      res.push({id:accepted.schedule,title:accepted.title,start:accepted?.pickupDate?.dateField_1
        ,end:accepted?.dropOffDate?.dateField_2 or accepted?.dropOffDate?.dateField_1,color:'#f0ad4e'})
    console.log res
    res

  isOccupied:->
    scheduleId=Session.get('assignMode')
    if scheduleId
      bid=Bids.findOne({'schedule._id':scheduleId,owner:@owner})
      schedules=Schedules.find({'resource.truck':@_id
        ,status:$in:[STATE_ASSIGNED,STATE_DISPATCH]}).fetch()
      res=Eztrucker.Utils.Trucks.getTruckAvailability(schedules,bid).length
      res

  isAssignMode:->
    Session.get('assignMode')

  pickup:()->
    distance=@pickupSettings?.coverageDistance?.value
    metric=@pickupSettings?.coverageDistance?.metric
    getCoverageDescription(@pickupSettings.coverage,distance,metric,"base location")
  dropoff:()->
    distance=@dropoffSettings?.coverageDistance?.value
    metric=@dropoffSettings?.coverageDistance?.metric
    getCoverageDescription(@dropoffSettings.coverage,distance,metric,"pickup location")
  volume:()->
    CommonHelpers.getTruckVolume(@)
