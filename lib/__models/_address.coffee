###Schema.LatLngBounds=new SimpleSchema
  'southwest.lat':
    type:Number
    decimal:true
  'southwest.lng':
    type:Number
    decimal:true
  'northeast.lat':
    type:Number
    decimal:true
  'northeast.lng':
    type:Number
    decimal:true###

Schema.AddressSchema =new SimpleSchema({
  formatted_address: {
    type: String
    autoform:
      'data-geo':'formatted_address'
  },
  loc:
    type:Object
    optional:true
    index:'2dsphere'
  'loc.type':
    type:String
    optional:true
  'loc.coordinates':
    type:[Number]
    optional:true
    decimal:true
  lat: {
    type: Number
    decimal: true
    optional:true
    autoform:
      'data-geo':'lat'
  },
  lng: {
    type: Number
    decimal: true
    optional:true
    autoform:
      'data-geo':'lng'
  },
  country: {
    type: String
    optional:true
    autoform:
      'data-geo':'country'
  },
  street_address: {
    type: String
    max: 100
    optional:true
    autoform:
      'data-geo':'street_address'
  },
  street_number: {
    type: String
    max: 50
    optional:true
    autoform:
      'data-geo':'street_number'
  },
  postal_code: {
    type: String,
    optional:true
    autoform:
      'data-geo':'postal_code'
  }});