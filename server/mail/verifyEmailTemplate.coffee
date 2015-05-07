Meteor.startup ()->
  Accounts.emailTemplates.from= 'ezTrucker<no-reply@ezTrucker.com>'
  Accounts.emailTemplates.siteName= 'eZTruckerApp.com'
  Accounts.emailTemplates.verifyEmail.subject=(user)->"Verify Your Registration"
  Accounts.emailTemplates.verifyEmail.text=(usr, url)->
        "click on the following link to verify your email address: #{url}"
  null