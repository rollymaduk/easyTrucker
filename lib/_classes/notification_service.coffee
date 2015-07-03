class @NotificationService
  createNotification:(message,objectId,parent,audience,tag)->
    notification={}
    Schema.Activity.clean(notification)
    notification={parentId:parent,message:message,objectId:objectId,audience:audience,tag:tag}
    Activities.insert(notification)