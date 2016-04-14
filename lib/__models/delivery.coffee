Schema.Delivery=new SimpleSchema
  hasIssue:
    type:Boolean
    defaultValue:false
  note:
    type:String
    optional:true
    autoform:
      afFieldInput:
        rows:5
  schedule:
    type:String
    optional:true
    autoform:
      type:'hidden'
      label:false
  photos:
    optional:true
    type:String
    autoform:
      type:'uploadCare'


