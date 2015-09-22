Schema.Activity=new SimpleSchema
  isNew:
    type:Boolean
    defaultValue:true
    autoform:
      type:'hidden'
      label:false
  title:
    type:String
  description:
    type:String
  parent:
    type:String
    optional:true
  documentId:
    type:String
    autoform:
      type:'hidden'
      label:false
  collectionName:
    type:String
    autoform:
      type:'hidden'
      label:false
  audience:
    type:[String]
    defaultValue:[]


