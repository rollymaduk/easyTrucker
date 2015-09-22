Notifications.after.insert (user,doc)->
  notify=Notifications.findOne(doc._id)
  buttonText='View notification'
  link=if (notify.notification.collectionName is COLLECTION_BID) then Meteor.absoluteUrl("app/bids/view/#{notify.notification.documentId}") else
    Meteor.absoluteUrl("app/loads/view/#{notify.notification.documentId}")

  console.log notify.notification.collectionName
  subject="EZTrucker Notification (#{notify.notification.title})"
  heading="You have a new notification!"
  message=if (notify.collectionName is COLLECTION_ACTIVITY) then notify.notification.description else notify.notification.message
  audience=Meteor.users.find(_id:$in:notify.audience).map (doc)->
    doc.profile.emails[0]
  console.log subject
  console.log message
  Meteor.call('sendCallToActionEmail',audience,subject,heading,message,buttonText,link)
