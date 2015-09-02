Messages.after.insert (user,doc)->
  notify={collectionName:COLLECTION_MESSAGE,documentId:doc._id,audience:doc.audience}
  Meteor.call 'createNotification',notify


