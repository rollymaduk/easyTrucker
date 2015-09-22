Schema.Pickup=new SimpleSchema
  shipmentTitle:
    type:String
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
    type:[String]
    autoform:
      template:'wizard_files'
  "memo.files.$":
    autoform:
      afFieldInput:
        type: 'fileUpload'
        collection: 'eZFiles'
        'remove-label':"change file"


Schema.Schedule=new SimpleSchema([Schema.Pickup,Schema.DropOff,Schema.Memo,
  {
    status:
      type: String
      allowedValues: [STATE_NEW, STATE_BOOKED, STATE_DISPATCH, STATE_CANCELLED, STATE_LATE, STATE_ISSUE, STATE_SUCCESS,
                      STATE_ASSIGNED]
      defaultValue: STATE_NEW
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
    bidders:
      type: [String]
      optional: true
      defaultValue: []
    messages:
      type: [Form.Message]
      defaultValue: []
      optional: true
    owner:
      type: String
      autoValue: ()->
        if @isInsert then Meteor.userId()
        else if @isUpsert then $setOnInsert: Meteor.userId()
        else @unset()
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
  }])



