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
  isPolicyValid:
    type:Boolean
    optional:true
    defaultValue:true
    autoform:
      label:false
      type:"hidden"

  InsuranceCompany:
    type:String

Schema.TruckSpecs=new SimpleSchema
  typeId:
    type:String
    optional:true
    autoform:
      type:"hidden"
  type:
    type:String
    label:"Type Of Vehicle"
    optional:true
  goodsType:
    type:[Object]
    blackbox:true
    optional:true
    autoform:
      type:"tagsTypeahead"
  volumeType:
    label:'Load Type'
    type:String
    optional:true
    allowedValues:['boxed','liquid','non-boxed']
    ###autoform:
      options:{boxed:'boxed',liquid:'liquid',"non-boxed":'non-boxed'}
      type:"hidden"###
  ###doors:
      type:String
      optional:true
      allowedValues:['rollup','barndoors']
      autoValue:->
        _voltype=@siblingField('volumeType')
        if(@isSet and !_.isEqual(_voltype.value,'boxed'))
          @unset()
          null
      autoform:
        options: {rollup:"roll-up",barndoors:"barn-doors"}###
  weight:
    type:Object
    optional:true

  'weight.value':
    type:Number
    decimal:true
  'weight.metric':
    type:String
    allowedValues:['lbs','kg','mt','cwt','per']
    autoform:
      options:{lbs:'Pounds',kg:'Kilograms',mt:'Metric Tonnes',cwt:"100 weights",per:"passenger(s)"}
  boxedVolume:
    type:Object
    optional:true
    autoValue:->
      _voltype=@siblingField('volumeType')
      if(@isSet and !_.isEqual(_voltype.value,'boxed'))
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
    allowedValues:['ft','m','cm','inch']
    autoform:
      options:{ft:'Feet',m:'Meters',cm:'Centimeters',inch:"Inches"}
  liquidVolume:
    type:Object
    optional:true
    autoValue:->
     _voltype=@siblingField('volumeType')
     if(@isSet and !_.isEqual(_voltype.value,'liquid'))
       @unset()
       null
  'liquidVolume.value':
    type:Number
    decimal:true
  'liquidVolume.metric':
    type:String
    allowedValues:['l','gal','ft3','bbl','ccm',]
    autoform:
      options:{l:'litres',gal:'gallons',ft3:'cubic feet',bbl:'barrels','ccm':'cubic meters'}


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
      options:{m:'Meters',km:'KM',mi:'Miles'}
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
  registration:
    type:String
    optional:true
  chasis:
    type:String
    optional:true
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

