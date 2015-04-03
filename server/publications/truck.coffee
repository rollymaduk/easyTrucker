Meteor.publish 'truckList',(user,limit)->
  limit=limit||50
  Trucks.find {},{limit:limit}