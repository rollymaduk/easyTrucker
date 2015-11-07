Eztrucker.Utils.User={
  getEmailsForUsers:(emails)->
    check(emails,[String])
    Meteor.users.find(emails).map (doc)->
      doc.emails[0].address
}