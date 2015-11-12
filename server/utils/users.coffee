Eztrucker.Utils.User={
  getEmailsForUsers:(emails)->
    check(emails,[String])
    Meteor.users.find(_id:$in:emails).map (doc)->
      doc.emails[0].address
}