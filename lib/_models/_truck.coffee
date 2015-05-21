Schema.TruckType=new SimpleSchema
  title:
    type:String

Schema.TruckInsurance=new SimpleSchema
  policyNumber:
    type:String
  expirationDate:
    type:Date
  InsuranceCompany:
    type:String

Schema.TruckSpecs=new SimpleSchema
  type:
    type:String
    optional:true
    autoform:
      label:false
      placeholder:"schemaLabel"
      options:{}
  volumeType:
    type:String
    allowedValues:['boxed','liquid','nonboxed']
    autoform:
      type:'select-radio'
      template:'buttonGroup'
      options:{boxed:'boxed',liquid:'liquid',nonboxed:'non-boxed'}
  doors:
    type:String
    optional:true
    allowedValues:['rollup','barndoors']
    autoform:
      options: {rollup:"roll-up",barndoors:"barn-doors"}
      template:'buttonGroup'
      type:'select-radio'
  weight:
    type:Number
    optional:true
    label:"Weight(tons)"
    autoform:
      label:false
      placeholder:"schemaLabel"
  volume:
    type:Object
    blackbox:true
    optional:true


Schema.Truck=new SimpleSchema
  truckSpecs:
    type:Schema.TruckSpecs
  Insurance:
    type:Schema.TruckInsurance
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
  chasis:
    type:String
    optional:true
    autoform:
      label:false
      placeholder:"schemaLabel"
  createdAt:
    type:Date
    autoform:
      type:'hidden'
    autoValue:()->
      if @isInsert then new Date;
      else if @isUpsert then $setOnInsert:new Date
      else @unset()
  owner:
    type:String
    autoform:
      type:'hidden'
    autoValue:()->
      if @isInsert then Meteor.userId()
      else if @isUpsert then $setOnInsert:Meteor.userId()
      else @unset()



