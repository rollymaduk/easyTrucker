@Trucks=new Meteor.Collection "#{Meteor.settings.public.dbPrefix}trucks"

Trucks.attachSchema Schema.Truck

Trucks.attachBehaviour('timestampable');

Trucks.allow
  insert:(user,doc)->true
  update:(user,doc,fields,modifier)->true
  remove:(user,doc)->true