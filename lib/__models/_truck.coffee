Schema.TruckInsurance=new SimpleSchema
  policyNumber:
    type:String
  expirationDate:
    type:Date
    autoform: {
      afFieldInput: {
        type: 'bootstrap-datetimepicker'
      }
    }
  InsuranceCompany:
    type:String

Schema.TruckSpecs=new SimpleSchema
  type:
    type:String
    optional:true
    allowedValues:['flatbed',
                   'reefer',
                   'reftruck',
                   'logcarrier',
                   'insul-food-liquid-tanker',
                   'non-insul-food-liquid-tanker',
                   'insul-non-food-liquid-tanker',
                   'non-insul-non-food-liquid-tanker',
                   'auto-trans']
    autoform:
      options:{
        'flatbed':'Flatbed','reefer':'Reefer','reftruck':'Refrigirated Truck','logcarrier':'Log Carrier',
        'insul-food-liquid-tanker':'Insulated Food grade Liquid Tanker',
        'non-insul-food-liquid-tanker':'Non-insulated Food grade Liquid Tanker',
        'insul-non-food-liquid-tanker':'Insulated non-Food grade Liquid Tanker',
        'non-insul-non-food-liquid-tanker':'Non-insulated non-Food grade Liquid Tanker',
        'auto-trans':'Auto-transporter'
      }
  volumeType:
    label:'Load Type'
    type:String
    allowedValues:['boxed','liquid','nonboxed']
    autoform:
      options:{boxed:'boxed',liquid:'liquid',nonboxed:'non-boxed'}
  doors:
    type:String
    optional:true
    allowedValues:['rollup','barndoors']
    autoValue:->
      _voltype=@field('volumeType')
      if(@isSet and not _.isEqual(_voltype.value,'boxed'))
        @unset()
        null
    autoform:
      options: {rollup:"roll-up",barndoors:"barn-doors"}
  weight:
    type:Number
    optional:true
    decimal:true
    min:0
    max:250
    label:"Weight(tons)"
  boxedVolume:
    type:Object
    optional:true
    autoValue:->
      _vol=@field('volumeType')
      if(@isSet and not _.isEqual(_vol.value,'boxed'))
        @unset()
        null
  'boxedVolume.width':
    type:Number
    decimal:true
  'boxedVolume.height':
    type:Number
    decimal:true
  'boxedVolume.length':
    type:Number
    decimal:true
  'boxedVolume.metric':
    type:String
    allowedValues:['ft','m','cm']
    autoform:
      options:{ft:'Feet',m:'Meters',cm:'Centimeters'}
   liquidVolume:
    type:Object
    optional:true
    autoValue:->
     _voltype=@field('volumeType')
     if(@isSet and not _.isEqual(_voltype.value,'liquid'))
       @unset()
       null
  'liquidVolume.value':
    type:Number
    decimal:true
  'liquidVolume.metric':
    type:String
    allowedValues:['l','gal','ft3','bbl']
    autoform:
      options:{l:'litres',gal:'gallons',ft3:'cubic feet',bbl:'barrels'}


Schema.TruckGeofence=new SimpleSchema
  baseLocation:
    type:Object
  'baseLocation.address':
    label:"Base Location"
    type:String
  'baseLocation.geometry':
    type:Schema.AddressSchema
  pickupSettings:
    type:Object
  'pickupSettings.coverage':
    type:String
    allowedValues:['international','usa','distance']
    autoform:
      options:{international:'International',usa:'USA & Canada',distance:'Distance from base location'}
  'pickupSettings.coverageDistance':
    label:'Distance from base location'
    type:Object
    optional:true
    autoValue:->
      _coverage=@siblingField('coverage')
      if(@isSet and not _.isEqual(_coverage.value,'distance'))
        @unset()
        null
  'pickupSettings.coverageDistance.value':
    type:Number
    decimal:true
  'pickupSettings.coverageDistance.metric':
    type:String
    allowedValues:['m','km','mi']
    autoform:
      options:{m:'Meters',k:'KM',mi:'Miles'}
  dropoffSettings:
    type:Object
  'dropoffSettings.coverage':
    type:String
    allowedValues:['international','usa','distance']
    autoform:
      options:{international:'International',usa:'USA & Canada',distance:'Distance from pickup location'}
  'dropoffSettings.coverageDistance':
    label:'Distance from pickup location'
    type:Object
    optional:true
    autoValue:->
      _coverage=@siblingField('coverage')
      if(@isSet and not _.isEqual(_coverage.value,'distance'))
        @unset()
        null
  'dropoffSettings.coverageDistance.value':
    type:Number
    decimal:true
  'dropoffSettings.coverageDistance.metric':
    type:String
    allowedValues:['m','km','mi']
    autoform:
      options:{m:'Meters',km:'KM',mi:'Miles'}



Schema.TruckGeneral=new SimpleSchema
  make:
    type:String
    optional:true
    autoform:
      placeholder:"schemaLabel"
  registration:
    type:String
    optional:true
    autoform:
      placeholder:"schemaLabel"
  chasis:
    type:String
    optional:true
    autoform:
      placeholder:"schemaLabel"
  isActive:
    type:Boolean
    defaultValue:true
    autoform:
      omit:true
  inUse:
    type:Boolean
    defaultValue:false
    autoform:
      omit:true
  createdAt:
    type:Date
    autoform:
      label:false
      type:'hidden'
    autoValue:()->
      if @isInsert then new Date;
      else if @isUpsert then $setOnInsert:new Date
      else @unset()
  owner:
    type:String
    autoform:
      label:false
      type:'hidden'
    autoValue:()->
      if @isInsert then Meteor.userId()
      else if @isUpsert then $setOnInsert:Meteor.userId()
      else @unset()

Schema.Truck=new SimpleSchema([Schema.TruckGeneral,Schema.TruckSpecs,Schema.TruckGeofence,Schema.TruckInsurance])

