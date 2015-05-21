
Meteor.users.attachSchema Schema.User,transform:(doc)->
  doc.fullname=()->
    "#{@profile.firstname} #{@profile.lastname}"
  doc
Meteor.users.allow
  insert:(user,doc)->true
  update:(user,doc,fields,modifier)->true
  remove:(user,doc)->true


