@Schedules=new Meteor.Collection('schedules')
Schedules.attachSchema Schema.Schedule,true
Schedules.attachSchema Schema.Pickup,true
Schedules.attachSchema Schema.DropOff,true
Schedules.attachSchema Schema.Artifacts,true
Schedules.attachSchema Schema.Memo,true
Schedules.allow
  insert:(user,doc)->true
  update:(user,doc,fields,modifier)->true
  remove:(user,doc)->true