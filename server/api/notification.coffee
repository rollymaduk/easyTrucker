Meteor.methods
  'sendRequestNotification':(doc,sender)->
    try
      @unblock()
      docId=doc._id
      link=Router.path('viewSchedule',doc)
      doc=_.omit(doc,'_id','updatedAt','createdAt','updatedBy','createdBy','changes')
      notifyObj=Eztrucker.Utils.Notification.getRequestNotificationItems(doc)
      audience=Eztrucker.Utils.Notification.getRequestNotificationRecipients(doc,sender)
      Rp_Notification.createNewNotification(_.extend(notifyObj,audience,{docId:docId,link:link}))
    catch err
      throw new Meteor.Error(err.id or 1201,err.message)


  'sendBidNotification':(doc,isNew)->
    try
      @unblock()
      docId=doc._id
      link=Router.path('bidDetail',doc)
      doc=_.omit(doc,'_id','updatedAt','createdAt','updatedBy','createdBy','changes')
      notifyObj=Eztrucker.Utils.Notification.getBidNotificationItems(doc,isNew)
      Rp_Notification.createNewNotification(_.extend(notifyObj,{docId:docId,link:link}))
    catch err
      throw new Meteor.Error(err.id or 1202,err.message)







