Meteor.publishRelations 'trucks',(qry,limit)->
  unless not @userId
    limit=limit or 50
    filter=qry?.filter or {}
    modifier=qry?.modifier or {}
    modifier['limit']=limit
    _.extend(filter,{owner:@userId})
    @cursor Trucks.find(filter,modifier),(docId,doc)->
      query='truckers.trucks':docId
      trucker=doc.owner
      @cursor Schedules.find(query,{fields:{status:1,resource:1,_id:1,pickupDate:1,dropOffDate:1}}),(docId,doc)->
        @cursor Bids.find({'schedule._id':docId,owner:trucker})
        null
      null
    @ready()

Meteor.publish 'truckItem',(id)->
  unless not @userId
    Trucks.find {_id:id,owner:@userId}

