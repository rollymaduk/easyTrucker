@Schedules=new Meteor.Collection 'schedules'
Schedules.attachSchema Schema.Schedule
Schedules.attachSchema Schema.Pickup
Schedules.attachSchema Schema.DropOff
Schedules.attachSchema Schema.Memo
Schedules.attachBehaviour('timestampable');
Schedules.attachBehaviour('trackable',{
  include:['status']
});
Schedules.allow
  insert:(user,doc)->true
  update:(user,doc,fields,modifier)->true
  remove:(user,doc)->true
