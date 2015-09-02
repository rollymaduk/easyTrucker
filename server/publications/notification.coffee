Meteor.publish('notifications',()->
  if @userId
   cursor= Notifications.find({audience:{$in:[@userId]},isNew:true})
   Notifications.publishJoinedCursors(cursor)
)