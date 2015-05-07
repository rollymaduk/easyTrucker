Schema.Bid=new SimpleSchema
  rate:
    label:'Rate Quote'
    type:Number
    defaultValue:0
    optional:true
    autoform:
      label:false
      placeholder:"schemaLabel"
  isNew:
    type:Boolean
    autoValue:()->
      if @isUpdate and @value is off then @unset()
      else if @isUpsert then $setOnInsert:on
      else on
    autoform:
      label:false
      type:'hidden'
  messages:
    type:[Form.Message]
    defaultValue:[]
  proposedDelivery:
    label:"Delivery Estimate"
    type:Date
    autoform:
      afFieldInput: {
        type: 'bootstrap-datetimepicker'
      }
      label:false
      placeholder:"schemaLabel"
  schedule:
    type:String
    optional:true
    autoform:
      label:false
      type:'hidden'
  owner:
    type:String
    autoValue:()->
      if @isInsert then Meteor.userId()
      else if @isUpsert then $setOnInsert:Meteor.userId()
      else @unset()
    autoform:
      label:false
      type:'hidden'
