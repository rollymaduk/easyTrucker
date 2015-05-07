
Meteor.users.attachSchema Schema.User
Meteor.users.allow
  insert:(user,doc)->true
  update:(user,doc,fields,modifier)->true
  remove:(user,doc)->true


