truckTypes=[title:'Flatbed',title:'Reefer',title:'Van']
Meteor.startup ->
  TruckTypes.add type for type in truckTypes if truckTypes.length is 0
  null
