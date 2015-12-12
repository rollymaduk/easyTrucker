Meteor.users.after.insert (user,doc)->
  if Meteor.settings.private.verifyEmailToLogin
    Meteor.call 'sendWelcomeMail',doc._id
  ###set app plans for users internally created users###
  plan = AppPlans.get({userId:doc._id})
  if (!plan)
    AppPlans.set(SUBSCRIBE_FREE, {userId:doc._id})
