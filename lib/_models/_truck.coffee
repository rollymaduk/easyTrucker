Schema.TruckType=new SimpleSchema
  title:
    type:String
Schema.Volume=new SimpleSchema
  length:
    type:Number
    label:"Length(feet)"
    optional:true
    autoform:
      label:false
      placeholder:"schemaLabel"
  width:
    type:Number
    label:"Width(feet)"
    optional:true
    autoform:
      label:false
      placeholder:"schemaLabel"
  height:
    type:Number
    label:"Height(feet)"
    optional:true
    autoform:
      label:false
      placeholder:"schemaLabel"

Schema.TruckSpecs=new SimpleSchema
  type:
    type:String
    optional:true
    autoform:
      label:false
      placeholder:"schemaLabel"
  doors:
    type:String
    allowedValues:['rollup','barndoors']
    autoform:
      options: {rollup:"roll-up",barndoors:"barn-doors"}
  weight:
    type:Number
    optional:true
    label:"Weight(tons)"
    autoform:
      label:false
      placeholder:"schemaLabel"
  volume:
    type:Schema.Volume
    optional:true


Schema.Truck=new SimpleSchema
  truckSpecs:
    type:Schema.TruckSpecs
  make:
    type:String
    optional:true
    autoform:
      label:false
      placeholder:"schemaLabel"
  registration:
    type:String
    optional:true
    autoform:
      label:false
      placeholder:"schemaLabel"
  color:
    type:String
    optional:true
    autoform:
      label:false
      placeholder:"schemaLabel"
  owner:
    type:String
    autoform:
      label:false
      placeholder:"schemaLabel"
  chasis:
    type:String
    optional:true
    autoform:
      label:false
      placeholder:"schemaLabel"


