@Notifications=new Meteor.Collection 'notifications'
Notifications.attachSchema Schema.Notification
Notifications.attachBehaviour('timestampable');
Notifications.allow
  insert:(user,doc)->true
  update:(user,doc,fields,modifier)->true
  remove:(user,doc)->true
