Template.bidDetail.helpers
  commentInsertDoc:()->
    audiences=CommonHelpers.getNotificationAudience([Template.currentData().scheduleItem.owner,Template.currentData().owner],Meteor.userId())
    {documentId:Template.currentData()._id,collectionName:COLLECTION_BID,audience:audiences}

  messages:()->
    Messages.find({documentId:Template.currentData()._id}).fetch()



