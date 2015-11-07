Template.bidDetail.helpers
  commentInsertDoc:()->
    audiences=CommonHelpers.getNotificationAudience([Template.currentData().schedule.owner,Template.currentData().owner],Meteor.userId())
    {documentId:Template.currentData()._id,collectionName:COLLECTION_BID,audience:audiences,parent:Template.currentData().schedule._id}

  messages:()->
    Messages.find({documentId:Template.currentData()._id}).fetch()



