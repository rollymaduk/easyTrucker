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
  ###messages:
    type:[Form.Message]
    optional:true
    defaultValue:[]###
  proposedPickup:
    type:Form.TimeFrame
  proposedDelivery:
    type:Form.TimeFrame
  schedule:
    type:String
    optional:true
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
