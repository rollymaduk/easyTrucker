Schema.Activity=new SimpleSchema
  isNew:
    type:Boolean
    defaultValue:true
    autoform:
      type:'hidden'
      label:false
  description:
    type:String
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


