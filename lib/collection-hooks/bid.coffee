service=new NotificationService()

Bids.after.update (user,doc,fieldnames,modifier,options)->
  if (not _.isEqual(@previous.proposedDelivery,doc.proposedDelivery) or not _.isEqual(@previous.rate,doc.rate))
    objectId=doc._id
    message=NotifyMessage.updateBid(doc.rate,doc.proposedDelivery)
    tag=NotifyTag.updateBid
    schedule=Schedules.findOne(doc.schedule)
    service.createNotification(message,objectId,doc.schedule,[schedule.owner],tag)


Bids.after.insert (user,doc)->
  objectId=@_id
  message=NotifyMessage.newBid
  tag=NotifyTag.newBid
  schedule=Schedules.findOne(doc.schedule)
  schedule.totalBids+1
  Meteor.call "addUpdateSchedule",schedule,(err,res)->
    if res then service.createNotification(message,objectId,doc.schedule,[schedule.owner],tag)
    else console.log err
