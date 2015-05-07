Meteor.publishRelations 'bidList',(scheduleId)->
  @cursor Bids.find({schedule:scheduleId}),(docId,doc)->
    @cursor Meteor.users.find(doc.owner,{fields:"profile.name":1})
    null
  @ready()