Rp_Comment.setModel([ {
    name:"request"
    audience:(doc)->
      driver=doc?.resource?.driver
      bidder=doc?.winningBid?.bidder
      owner=doc?.owner
      _.uniq(_.compact([driver,bidder,owner]))
  },
  {
    name: "bids"
    audience: (doc)->
      _.without([doc.schedule.owner, doc.owner], Meteor.userId())
  }
])
Rp_Comment.commentChanged=(comment)->
  {message}=comment
  notification=_.extend(_.omit(comment,'updatedAt','updatedBy','createdAt','createdBy','_id'),{description:message})
  notification.collection=COLLECTION_COMMENT
  Rp_Notification.createNewNotification(notification)

Rp_Comment.replyChanged=(reply,docId)->
  notification={description:reply.message,collection:COLLECTION_COMMENT,docId:docId,audience:reply.audience}
  Rp_Notification.createNewNotification(notification)

