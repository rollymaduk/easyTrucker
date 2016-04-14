Rp_Comment.setModel([ {
    name:"request"
    audience:(doc)->
      driver=doc?.resource?.driver
      bidder=doc?.winningBid?.bidder
      owner=doc?.owner
      _.without(_.uniq(_.compact([driver,bidder,owner])),Meteor.userId())
  },
  {
    name: "bids"
    audience: (doc)->
      _.without([doc.schedule.owner, doc.owner], Meteor.userId())
  }
])
Rp_Comment.commentChanged=(comment)->
  {message}=comment
  linkId=if comment.collection is COLLECTION_BID then comment.parent else comment.docId
  notification=_.extend(_.omit(comment,'updatedAt','updatedBy','createdAt','createdBy','_id'),{description:message})
  notification.collection=COLLECTION_COMMENT
  notification.link="#{Router.path('viewSchedule',{_id:linkId})}##{comment.docId}"
  Rp_Notification.createNewNotification(notification)

Rp_Comment.replyChanged=(reply)->
  notification={description:reply.message,collection:COLLECTION_COMMENT,docId:reply.refId,audience:reply.audience}
  comment=Rp_Comments.findOne(reply.refId)
  linkId=if comment.collection is COLLECTION_BID then comment.parent else comment.docId
  notification.link="#{Router.path('viewSchedule',{_id:linkId})}##{reply.refId}-#{moment(reply.updatedAt).unix()}"
  Rp_Notification.createNewNotification(notification)

