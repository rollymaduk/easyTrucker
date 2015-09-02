Meteor.publish 'bids',(qry)->
  isSchedule=isSchedule or false
  if(@userId)
    cursor=Bids.find(qry)
    Bids.publishJoinedCursors(cursor)

Meteor .publishRelations 'bidItem',(qry)->
  @cursor Bids.find(qry),(docId,doc)->
    @cursor Schedules.find(doc.schedule)
    @cursor Messages.find({documentId:docId})
    @cursor Activities.find(documentId:docId)
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
