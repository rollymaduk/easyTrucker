Schema.Artifact=new SimpleSchema
  title:
    type:String
    optional:true
  type:
    type:String
    defaultValue:'file'
    allowedValues:['location','comment','file','photo','video','audio']
  payload:
    type:Object
    blackbox:true
    optional:true

Schema.Pickup=new SimpleSchema
  wayBill:
    type:String
    label:"Way Bill #"
  sender:
    type:String
    label:"Pick up Customer"
  pickupDate:
    type:Form.TimeFrame
  pickupLocation:
    type:Object
  'pickupLocation.address':
    type:String
  'pickupLocation.geometry':
    optional:true
    type:Schema.AddressSchema
    autoform:
      omit:true


Schema.DropOff=new SimpleSchema
  receiver:
    type:String
  dropOffDate:
    type:Form.TimeFrame
  dropOffLocation:
    type:Object
  'dropOffLocation.address':
    type:String
  'dropOffLocation.geometry':
    type:Schema.AddressSchema
    optional:true
    autoform:
     omit:true

###Schema.AddressPropertySchema=new SimpleSchema
  address:
    type:Schema.AddressSchema
    autoform:
      type:'googleplace'###

Schema.Memo=new SimpleSchema
  shipmentTitle:
    type:String
  specs:
    label:"Van Specifications"
    type:Schema.TruckSpecs
    optional:true
  truckers:
    type:[Object]
    defaultValue:[]
    autoform:
      omit:true
  'truckers.$.owner':
    type:String
  'truckers.$.trucks':
    type:[String]
  memo:
    type:String
    optional:true
    autoform:
      afFieldInput:
        rows:8

Schema.Artifacts=new SimpleSchema
  artifacts:
    type:[Schema.Artifact]
    optional:true

Schema.Schedule=new SimpleSchema
  status:
    type:String
    allowedValues:[STATE_UNMATCHED,STATE_MATCHED,STATE_BOOKED,STATE_DISPATCH,STATE_CANCELLED,STATE_LATE,STATE_ISSUE,STATE_SUCCESS]
    defaultValue:STATE_UNMATCHED
  shipmentDistance:
    type:Number
    decimal:true
    autoform:
      omit:true
  totalBids:
    type:Number
    defaultValue:0
    optional:true
    autoform:
      omit:true
  messages:
    type:[Form.Message]
    defaultValue:[]
    optional:true
  createdAt:
    type:Date
    autoValue:()->
      if @isInsert then new Date;
      else if @isUpsert then $setOnInsert:new Date
      else @unset()
  owner:
    type:String
    autoValue:()->
      if @isInsert then Meteor.userId()
      else if @isUpsert then $setOnInsert:Meteor.userId()
      else @unset()
  truck:
    type:String
    optional:true
  driver:
    type:String
    max:250
    optional:true



