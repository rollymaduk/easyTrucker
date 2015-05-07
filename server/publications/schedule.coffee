Meteor.publishRelations 'scheduleList',(user,limit)->
  limit=limit or 50
  service= new QueryFilterService(@)
  query=service.scheduleListByRoles()
  unless not query
    userId=@userId
    query.modifier['limit']=limit
    @cursor Schedules.find(query.filter,query.modifier),(docId,doc)->
      @cursor(Bids.find({schedule:docId},fields:{_id:1,schedule:1,owner:1}))
      null

  @ready()


Meteor.publishRelations 'scheduleItem',(scheduleId,userId)->
  userId=userId or @userId
  @cursor(Schedules.find(scheduleId),(docId,doc)->
    ###doc.bid=@changeParentDoc(Bids.find({schedule:docId,owner:userId}),(bidId,bid)->
      bid
    )###
    @cursor(Bids.find({schedule:docId,owner:userId}))
    null
  )
  @ready()

###
Meteor.publish 'scheduleItem' ,(id)->
  Schedules.find(id)###
