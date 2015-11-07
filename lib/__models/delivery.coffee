Schema.Delivery=new SimpleSchema
  hasIssue:
    type:Boolean
    defaultValue:false
    autoform:
      label:false
      afFieldInput:
        type:"fancy-checkbox"
        class:"warning"
        id:"issue"
  note:
    type:String
    optional:true
    autoform:
      afFieldInput:
        rows:5
  schedule:
    type:String
    autoform:
      type:'hidden'
      label:false
  photos:
    optional:true
    type:String
    autoform:
      type:'hidden'
      label:false

