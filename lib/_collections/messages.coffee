@Messages=new Meteor.Collection 'messages'
Messages.attachSchema Schema.Message
Messages.attachBehaviour('timestampable');
Messages.allow
  insert:(user,doc)->true
  update:(user,doc,fields,modifier)->true
  remove:(user,doc)->true
