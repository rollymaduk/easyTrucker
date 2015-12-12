if Meteor.isClient
  Rp_Notification.notificationAdded=(notification)->
    if _.contains(notification.audience,Meteor.userId())
      notification.title=notification.title or "Eztrucker Notification"
      Rp_notify_js.show(notification.title,notification.description)

      ###sAlert.success(notification.description)###
if Meteor.isServer
  Rp_Notification.notificationAdded=(notification)->
    recipients=Eztrucker.Utils.User.getEmailsForUsers(notification.audience)
    console.log recipients
    sender=Meteor.users.findOne(notification.createdBy).profile.companyName
    if notification.link
      link=Meteor.absoluteUrl(notification.link.substr(notification.link.indexOf('/') + 1))
    console.log link
    data={title:notification.title,description:notification.description,link_url:link or null,sender:sender}
    emails=Rp_swu_mailer.createMailItems(notification.collection,recipients,data)
    Rp_swu_mailer.send(emails)

###
if Meteor.isServer
  Rp_Notification.notificationAdded=(notification)->
    switch notification.collection
      when COLLECTION_COMMENT###
