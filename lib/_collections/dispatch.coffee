@Dispatches=new Meteor.Collection 'dispatches'
Dispatches.attachSchema Schema.Dispatch
Dispatches.attachBehaviour('timestampable');
Dispatches.allow
  insert:(user,doc)->true
  update:(user,doc,fields,modifier)->true
  remove:(user,doc)->true