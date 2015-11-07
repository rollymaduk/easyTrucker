Meteor.methods
  sendWelcomeMail:(user)->
    @unblock()
    recipient=Meteor.users.findOne(user)
    ###register user in subscription plans###
    AppPlans.pullFromEmail(recipient.emails[0].address)
    ###=======================================###
    tokenRecord =
      token: Random.secret(),
      address: recipient.emails[0].address,
      when: new Date()
    ###update user with registration token###
    Meteor.users.update(_id:user,{$push: {'services.email.verificationTokens': tokenRecord}})
    fullname="#{recipient.profile.firstname} #{recipient.profile.lastname}"
    ###generate verification link###
    link=Eztrucker.Utils.Notification.getNotificationLink(COLLECTION_USER,{token:tokenRecord.token})
    emailObject=Rp_swu_mailer.createMailItem(Meteor.settings.private.activation_email_template
    ,recipient.emails[0].address,{full_name:fullname,link:link})
    ###send welcome mail with service###
    Rp_swu_mailer.send([emailObject])
    ###track user signup with threads###
    Rp_Threads.identify({email:recipient.emails[0].address},user,(err,res)->
      if res
        Rp_Threads.track('signUp',{email:recipient.emails[0].address},user,(err,res)->)
    )

