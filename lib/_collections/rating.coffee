@Ratings=new Meteor.Collection 'ratings'
Ratings.attachSchema Schema.Rating
Ratings.attachBehaviour('timestampable');
Ratings.allow
  insert:(user,doc)->true
  update:(user,doc,fields,modifier)->true
  remove:(user,doc)->true