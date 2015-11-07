Schema.BidScheduleMeta=new SimpleSchema
  _id:
    type:String
    autoform:
      type:"hidden"
      label:false
  maximumBidPrice:
    type:Number
    defaultValue:0
    optional:true
    autoform:
      type:"hidden"
      label:false
  shipmentTitle:
    type:String
    autoform:
      type:"hidden"
      label:false
  pickupDate:
    type:Form.TimeFrame
  dropOffDate:
    type:Form.TimeFrame
  owner:
    type:String
    autoform:
      type:"hidden"
      label:false


Schema.Bid=new SimpleSchema
  quote:
    label:'Quote'
    type:Number
    defaultValue:0
    optional:true
  isNew:
    type:Boolean
    autoValue:()->
      if @isUpdate and @value is off then @unset()
      else if @isUpsert then $setOnInsert:on
      else on
    autoform:
      omit:true
  schedule:
    type:Schema.BidScheduleMeta
    autoform:
      type:"hidden"
      label:false
  owner:
    type:String
    autoValue:()->
      if @isInsert then Meteor.userId()
      else if @isUpsert then $setOnInsert:Meteor.userId()
      else @unset()
    autoform:
      omit:true

@bidSchemaContext=Schema.Bid.namedContext('placeBidForm')
