Schema.UserProfile=new SimpleSchema
  firstName:
    type:String
    optional:true
  lastName:
    type:String
    optional:true
  gender:
    type:String
    optional:true
    allowedValues:['male','female']
  telephones:
    optional:true
    type:[String]
    minCount:1
  bio:
    type:String
    optional:true



