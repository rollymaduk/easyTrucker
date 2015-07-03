Meteor.publishRelations 'bidList',(scheduleId)->
  @cursor Bids.find({schedule:scheduleId}),(docId,doc)->
    @cursor Meteor.users.find(doc.owner,{fields:"profile":1})
    null
  @ready()