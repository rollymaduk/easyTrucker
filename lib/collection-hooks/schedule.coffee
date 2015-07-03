
service=new NotificationService()
Schedules.after.insert (user,doc)->
  objectId=@_id
  message=NotifyMessage.newRequest
  tag=NotifyTag.newRequest
  service.createNotification(message,objectId,null,doc.truckers,tag)