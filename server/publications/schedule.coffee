Meteor.publishRelations 'scheduleList',(qry,limit)->
  console.log qry
  limit=limit or 50
  service= new QueryFilterService(@)
  query=service.scheduleListByRoles()
  unless not query
    userId=@userId
    filter=qry?.filter
    modifier=qry?.modifier
    _.extend query.filter,filter if filter
    _.extend query.modifier,modifier if modifier
    query.modifier['limit']=limit
    console.log query
    @cursor Schedules.find(query.filter,query.modifier),(docId,doc)->
      @cursor(Bids.find({schedule:docId,owner:userId},fields:{schedule:1,owner:1}))
      null
  @ready()


Meteor.publishRelations 'scheduleItem',(scheduleId,userId)->
  userId=userId or @userId
  @cursor(Schedules.find(scheduleId),(docId,doc)->
    ###doc.bid=@changeParentDoc(Bids.find({schedule:docId,owner:userId}),(bidId,bid)->
      bidmete
    )###
    @cursor(Bids.find({schedule:docId,owner:userId},fields:{schedule:1,owner:1}))

    @cursor(Meteor.users.find({_id:$in:_.pluck(doc.messages,'owner')},{fields:profile:1}))

    null
  )
  @ready()

###
Meteor.publish 'scheduleItem' ,(id)->
  Schedules.find(id)###
