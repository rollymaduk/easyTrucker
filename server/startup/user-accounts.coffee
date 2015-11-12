Meteor.startup ->
  loginAttemptVerifier =(parameters)->
    if (parameters.user && parameters.user.emails && (parameters.user.emails.length > 0))
      found = _.find(parameters.user.emails,(thisEmail)->thisEmail.verified)
      unless found
        throw new Meteor.Error(500, 'We sent you an email.')
      else
        found && parameters.allowed
    else
      console.log("user has no registered emails.")
      return false;
  if Meteor.settings.private.verifyEmailToLogin
    Accounts.validateLoginAttempt(loginAttemptVerifier)

  Accounts.onCreateUser (options,user)->
    console.log options
    user.profile= options.profile if options.profile
    email = user?.emails[0]?.address
    user.appPlans=AppPlans.pullFromEmail(email) if email
    user










