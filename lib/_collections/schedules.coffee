@Schedules=new Meteor.Collection "#{Meteor.settings.public.dbPrefix}schedules"
Schedules.attachSchema Schema.Schedule
Schedules.attachBehaviour('timestampable');
Schedules.allow
  insert:(user,doc)->true
  update:(user,doc,fields,modifier)->true
  remove:(user,doc)->true
