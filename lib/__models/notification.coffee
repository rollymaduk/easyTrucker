Schema.Notification=new SimpleSchema
  isNew:
    type:Boolean
    defaultValue:true
  collectionName:
    type:String
  documentId:
    type:String
  parent:
    type:String
    optional:true
  audience:
    type:[String]
    defaultValue:[]

