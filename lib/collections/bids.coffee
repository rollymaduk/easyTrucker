@Bids=new Meteor.Collection 'bids'
Bids.attachSchema Schema.Bid
Bids.allow
  insert:(user,doc)->true
  update:(user,doc,fields,modifier)->true
  remove:(user,doc)->true