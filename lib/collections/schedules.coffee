@Schedules=new Meteor.Collection 'schedules',transform:(doc)->
  doc.truckVolume=()->
    "W:#{this.specs.volume.width}ft x L:#{this.specs.volume.length}ft x H:#{this.specs.volume.height}ft"
  doc
Schedules.attachSchema Schema.Schedule
Schedules.attachSchema Schema.Pickup
Schedules.attachSchema Schema.DropOff
Schedules.attachSchema Schema.Artifacts
Schedules.attachSchema Schema.Memo
Schedules.allow
  insert:(user,doc)->true
  update:(user,doc,fields,modifier)->true
  remove:(user,doc)->true
