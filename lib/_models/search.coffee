Schema.Search=new SimpleSchema
  origin:
    type:Schema.AddressSchema
    optional:true
  destination:
    type:Schema.AddressSchema
    optional:true
  specs:
    type:Schema.TruckSpecs
    optional:true
  pickupDate:
    type:Date
    optional:true
  dropOffDate:
    type:Date
    optional:true

