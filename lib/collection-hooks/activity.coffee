Activities.after.insert (user,doc)->
  notify={parent:doc.parent,collectionName:COLLECTION_ACTIVITY,documentId:doc._id,audience:doc.audience}
  Meteor.call 'createNotification',notify