Meteor.publishRelations 'bids',(qry)->
  if(@userId)
    @cursor Bids.find(qry),(docId,doc)->
      @cursor Schedules.find(doc.schedule,CommonHelpers.getScheduleFieldsLight()) if doc.schedule
      @cursor Activities.find({documentId:docId},{limit:1,sort:{createdAt:-1}}) if docId
      @cursor Messages.find({documentId:docId},{limit:1,sort:{createdAt:-1}}) if docId
      @cursor Meteor.users.find(doc.owner,{fields:profile:1}) if doc.owner
      null
    @ready()

Meteor.publishRelations 'bidItem',(qry)->
  if(@userId)
    @cursor Bids.find(qry),(docId,doc)->
      @cursor Schedules.find(doc.schedule,CommonHelpers.getScheduleFieldsLight()) if doc.schedule
      null
    @ready()

    ### Bids.publishJoinedCursors(cursor)###

Meteor.publishRelations 'bidDetailItem',(qry)->
  if @userId
    @cursor Bids.find(qry),(docId,doc)->
      @cursor Schedules.find(doc.schedule,CommonHelpers.getScheduleFieldsLight()) if doc.schedule
      @cursor Messages.find({documentId:docId}) if docId
      @cursor Activities.find(documentId:docId) if docId
      @cursor Meteor.users.find(doc.owner,{fields:profile:1}) if doc.owner
      null
    @ready()
###
Meteor.publishRelations 'bidList',(scheduleId)->
  if(@userId)
    check(scheduleId,String)
    @cursor Schedules.find({_id:scheduleId,status:STATE_NEW}),(docId,doc)->
      @cursor Bids.find({schedule:docId}),(docId,doc)->
        @cursor Meteor.users.find(doc.owner,{fields:profile:1})
        null
  @ready()

Meteor.publishRelations 'bidItem',(bidId,isSchedule)->
  isSchedule=isSchedule or false
  if @userId
    check(bidId,String)
    check(isSchedule,Boolean)
    qry=if isSchedule then schedule:bidId,owner:@userId else bidId
    console.log qry
    @cursor Bids.find(qry),(docId,doc)->
      @cursor Schedules.find(doc.schedule,{fields:shipmentTitle:1})
      @cursor Meteor.users.find(doc.owner,{fields:profile:1})
      null
  @ready()###
