@Trucks=new Meteor.Collection 'trucks',transform:(doc)->
  doc.volume=()->
    "W:#{this.truckSpecs.volume.width}ft x L:#{this.truckSpecs.volume.length}ft x H:#{this.truckSpecs.volume.height}ft"
  doc
Trucks.attachSchema Schema.Truck,true
Trucks.allow
  insert:(user,doc)->true
  update:(user,doc,fields,modifier)->true
  remove:(user,doc)->true