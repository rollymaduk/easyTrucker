class @NotificationService
  createNotification:(message,objectId,parent,audience,tag)->
    notification={parentId:parent,message:message,objectId:objectId,audience:audience,tag:tag}
    Schema.Activity.clean(notification)
    Activities.insert(notification)