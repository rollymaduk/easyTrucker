Meteor.publish 'truckTypeList',(user,limit)->
  limit=limit||50
  TruckTypes.find {},{limit:limit}