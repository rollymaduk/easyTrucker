Meteor.methods
  sendWelcomeMail:(user)->
    @unblock()
    recipient=Meteor.users.findOne(user)
    ###register user in subscription plans###
    ###AppPlans.pullFromEmail(recipient.emails[0].address)###
    ###=======================================###

    link=Eztrucker.Utils.Emails.prepareEnrollmentEmail(recipient)
    fullname="#{recipient.profile.firstname} #{recipient.profile.lastname}"
    ###generate verification link###
    ###link=Eztrucker.Utils.Notification.getNotificationLink(COLLECTION_USER,{token:tokenRecord.token})###
    emailObject=Rp_swu_mailer.createMailItem("welcome",recipient.emails[0].address,{full_name:fullname,link:link})
    ###send welcome mail with service###
    Rp_swu_mailer.send([emailObject])
    ###track user signup with threads###

    Rp_Threads.identify({email:recipient.emails[0].address},user,(err,res)->
      if res
        Rp_Threads.track('signUp',{email:recipient.emails[0].address},user,(err,res)->)
    )

