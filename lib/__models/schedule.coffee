Schema.Pickup=new SimpleSchema
  shipmentTitle:
    type:String
  wayBill:
    type:String
    optional:true
    label:"Way Bill #"
    autoform:
      readOnly:true
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

@dropSchemaContext=Schema.DropOff.namedContext('dof')

###Schema.AddressPropertySchema=new SimpleSchema
  address:
    type:Schema.AddressSchema
    autoform:
      type:'googleplace'###

Schema.Memo=new SimpleSchema
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
    optional:true
    type:String
  'truckers.$.trucks':
    optional:true
    type:[String]
  maximumBidPrice:
    type:Number
    defaultValue:0
    optional:true
  memo:
    type:Object
    optional:true
  'memo.notes':
    type:String
    autoform:
      afFieldInput:
        rows:8
  'memo.files':
    optional:true
    type:String
    autoform:
      type:'uploadCare'



Schema.Schedule=new SimpleSchema([Schema.Pickup,Schema.DropOff,Schema.Memo,
  {
    status:
      type: String
      allowedValues: ALL_ACTIVE_STATES
      defaultValue: STATE_NEW
    nextStep:
      type:String
      allowedValues: ALL_ACTIVE_STATES
      defaultValue:STATE_EXPIRE
    shipmentDistance:
      type: Number
      decimal: true
      autoform:
        omit: true
    totalBids:
      type: Number
      defaultValue: 0
      optional: true
      autoform:
        omit: true
    isLate:
      type:Boolean
      defaultValue:false
      optional:true
    bidders:
      type: [String]
      optional: true
      defaultValue: []
    owner:
      type: String
      autoValue: ()->
        if @isInsert then Meteor.userId()
        else if @isUpsert then $setOnInsert: Meteor.userId()
        else @unset()
    charge:
      type:[Object]
      optional:true
    'charge.$.group':
      type:String
    'charge.$.id':
      type:String
    winningBid:
      type: Object
      optional: true
    'winningBid.bidder':
      type: String
    'winningBid.bid':
      type: String
    resource:
      type: Object
      optional: true
    'resource.truck':
      type: String
      optional: true
    'resource.driver':
      type: String
      max: 250
      optional: true
    dispatch:
      type:Schema.Dispatch
      optional:true
    delivery:
      type:Schema.Delivery
      optional:true

  }])



