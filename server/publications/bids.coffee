Meteor.publishRelations 'bidList',(scheduleId)->
  if(@userId)
    check(scheduleId,String)
    @cursor Bids.find({schedule:scheduleId}),(docId,doc)->
      @cursor Meteor.users.find(doc.owner,{fields:profile:1})
      null
  @ready()


Meteor.publishRelations 'bidItem',(bidId)->
  if @userId
    check(bidId,String)
    @cursor Bids.find(bidId),(docId,doc)->
      @cursor Schedules.find(doc.schedule,{fields:shipmentTitle:1})
      @cursor Meteor.users.find(doc.owner,{fields:profile:1})
      null
  @ready()