Meteor.startup ()->
  if Meteor.settings.configMail
    process.env.MAIL_URL = "smtp:// #{encodeURIComponent(Meteor.settings.smtp.username)}:
    #{encodeURIComponent(Meteor.settings.smtp.password)}@#{encodeURIComponent(Meteor.settings.smtp.server)}:#{Meteor.settings.smtp.port}"


  PrettyEmail.options =
    from: Meteor.settings.public.from,
    logoUrl: Meteor.absoluteUrl(Meteor.settings.public.logoUrl),
    companyName: Meteor.settings.public.companyName,
    companyUrl: Meteor.settings.public.companyUrl,
    companyAddress: Meteor.settings.public.companyAddress,
    companyTelephone: Meteor.settings.public.companyTelephone,
    companyEmail: Meteor.settings.public.companyEmail,
    siteName: Meteor.settings.public.siteName

  PrettyEmail.style =
    fontFamily:  'Open Sans,sans-serif'
    buttonColor: '#FFFFFF'
    buttonBgColor: '#1ab394'

  PrettyEmail.defaults.verifyEmail=
    buttonUrl: Meteor.absoluteUrl(Meteor.settings.public.appPath)
