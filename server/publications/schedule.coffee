Meteor.publishRelations 'scheduleList',(qry,limit)->
  limit=limit or 50
  service= new QueryFilterService(@)
  query=service.scheduleListByRoles()
  console.log query
  unless not query
    userId=@userId
    filter=qry?.filter
    modifier=qry?.modifier
    _.extend query.filter,filter if filter
    _.extend query.modifier,modifier if modifier
    query.modifier['limit']=limit
    ###console.log query.filter###
    @cursor Schedules.find(query.filter,query.modifier),(docId,doc)->
      @cursor(Bids.find({schedule:docId,owner:userId},fields:{proposedDelivery:1,proposedPickup:1,schedule:1,owner:1}))
      null
  @ready()


Meteor.publishRelations 'scheduleItem',(scheduleId,userId)->
  userId=userId or @userId
  @cursor(Schedules.find(scheduleId),(docId,doc)->
    ###doc.bid=@changeParentDoc(Bids.find({schedule:docId,owner:userId}),(bidId,bid)->
      bidmete
    )###
    files=Meteor._get(doc, "memo", "files")
    @cursor eZFiles.find({_id:$in:files}) if files
    @cursor(Bids.find({schedule:docId,owner:userId},fields:{proposedDelivery:1,proposedPickup:1,schedule:1,owner:1}))
    @cursor Messages.find({documentId:docId}),(docId,doc)->
      photo=Meteor._get(doc, "owner", "profile","photo")
      @cursor eZImages.find(photo) if photo
    @cursor Activities.find(documentId:docId)
    ###@cursor(Meteor.users.find({_id:$in:_.pluck(doc.messages,'owner')},{fields:profile:1}))###

    null
  )
  @ready()

###
Meteor.publish 'scheduleItem' ,(id)->
  Schedules.find(id)###
