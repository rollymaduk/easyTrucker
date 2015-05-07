Meteor.startup ()->
  smtp = username: 'rolly.maduk@gmail.com', password: 'Allowme321^&*', server:'smtp.gmail.com', port: 25
  ###process.env.MAIL_URL = "smtp:// #{encodeURIComponent(smtp.username)}:
  #{encodeURIComponent(smtp.password)}@#{encodeURIComponent(smtp.server)}:#{smtp.port}"###
  null
