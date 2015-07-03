@TruckTypes=new Meteor.Collection 'truckType'
TruckTypes.attachSchema Schema.TruckType,true
TruckTypes.allow
  insert:(user,doc)->true
  update:(user,doc,fields,modifier)->true
  remove:(user,doc)->true