Meteor.users.after.insert (user,doc)->
  if Meteor.isServer
    sendWithUsApi.send
      email_id:ACTIVATION_EMAIL
      recipient:{address:doc.emails[0].address}
      email_data:
        full_name: "#{doc.firstname} #{doc.lastname}"
        activation_link: "#"
