Activities.after.insert (user,doc)->
  notify={collectionName:COLLECTION_ACTIVITY,documentId:doc._id,audience:doc.audience}
  Meteor.call 'createNotification',notify