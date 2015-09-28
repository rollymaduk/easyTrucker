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
  if Meteor.settings.public.verifyEmailToLogin
    Accounts.validateLoginAttempt(loginAttemptVerifier)
  null
