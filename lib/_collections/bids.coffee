@Bids=new Meteor.Collection 'bids'
Bids.attachSchema Schema.Bid
Bids.attachBehaviour('timestampable');
Bids.attachBehaviour('trackable',{
  include:['proposedPickup','proposedDelivery','qoute']
});
Bids.allow
  insert:(user,doc)->true
  update:(user,doc,fields,modifier)->true
  remove:(user,doc)->true