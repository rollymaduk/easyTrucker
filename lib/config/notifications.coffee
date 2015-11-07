if Meteor.isClient
  Rp_Notification.notificationAdded=(notification)->
    if _.contains(notification.audience,Meteor.userId())
      toastr.success(notification.description, notification.title);

      ###sAlert.success(notification.description)###
if Meteor.isServer
  Rp_Notification.notificationAdded=(notification)->
    template=Meteor.settings.public.Swu.templates[notification.collection]
    recipients=Eztrucker.Utils.User.getEmailsForUsers(notification.audience)
    data={title:notification.title,description:notification.description,link:notification.link}
    emails=Rp_swu_mailer.createMailItem(template,recipients,data)
    Rp_swu_mailer.send(emails)

###
if Meteor.isServer
  Rp_Notification.notificationAdded=(notification)->
    switch notification.collection
      when COLLECTION_COMMENT###
