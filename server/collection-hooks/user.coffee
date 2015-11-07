Meteor.users.after.insert (user,doc)->
 Meteor.call 'sendWelcomeMail',doc._id
