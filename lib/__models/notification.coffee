Schema.Notification=new SimpleSchema
  isNew:
    type:Boolean
    defaultValue:true
  collectionName:
    type:String
  documentId:
    type:String
  audience:
    type:[String]
    defaultValue:[]

