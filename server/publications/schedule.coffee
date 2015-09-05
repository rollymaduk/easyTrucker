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
    _.extend query.modifier,CommonHelpers.getScheduleFieldsLight()
    query.modifier['limit']=limit
    ###console.log query.filter###
    @cursor Schedules.find(query.filter,query.modifier),(docId,doc)->
      @cursor(Bids.find({schedule:docId,owner:userId},fields:{proposedDelivery:1,proposedPickup:1,schedule:1,owner:1})) if docId
      @cursor Activities.find(documentId:docId,{limit:1,sort:{createdAt:-1}}) if docId
      @cursor Messages.find({documentId:docId},{limit:1,sort:{createdAt:-1}}) if docId
      null
  @ready()

Meteor.publish 'scheduleItem',(scheduleId)->
  if @userId
   Schedules.find(scheduleId,CommonHelpers.getScheduleFieldsLight())


Meteor.publishRelations 'scheduleDetailItem',(scheduleId)->
  if @userId
    userId=@userId
    @cursor(Schedules.find(scheduleId),(docId,doc)->
      files=Meteor._get(doc, "memo", "files")
      @cursor eZFiles.find({_id:$in:files}) if files
      @cursor Activities.find({documentId:docId}) if docId
      @cursor(Bids.find({schedule:docId,owner:userId},fields:{proposedDelivery:1,proposedPickup:1,schedule:1,owner:1})) if docId
      if docId
        @cursor Messages.find({documentId:docId}),(docId,doc)->
          photo=Meteor._get(doc, "owner", "profile","photo")
          @cursor eZImages.find(photo) if photo
          null
      null
    )
  @ready()

###
Meteor.publish 'scheduleItem' ,(id)->
  Schedules.find(id)###
