@Deliveries=new Meteor.Collection 'Deliveries'
Deliveries.attachSchema Schema.Delivery
Deliveries.attachBehaviour('timestampable');
Deliveries.allow
  insert:(user,doc)->true
  update:(user,doc,fields,modifier)->true
  remove:(user,doc)->true