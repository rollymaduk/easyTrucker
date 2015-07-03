Meteor.publishRelations 'truckList',(limit)->
  unless not @userId
    limit=limit or 50
    @cursor Trucks.find({owner:@userId},{limit:limit}),(docId,doc)->
      query='truckers.trucks':docId
      @cursor Schedules.find(query,{fields:truckers:1})
      null
    @ready()

###Meteor.publish 'truckList',(limit)->
  unless not @userId
    limit=limit||50
    Trucks.find {owner:@userId},{limit:limit}###


Meteor.publish 'truckItem',(id)->
  unless not @userId
    Trucks.find {_id:id,owner:@userId}

