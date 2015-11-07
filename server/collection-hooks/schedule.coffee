Schedules.after.insert (user,doc)->
  Meteor.call 'sendRequestNotification',doc,user


Schedules.after.update (user,doc,fieldnames,mod,options)->
  if @previous.status isnt doc.status
    Meteor.call 'sendRequestNotification',doc,user

