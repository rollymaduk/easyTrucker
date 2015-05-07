Schema.User=new SimpleSchema
  username:
    type:String
  emails:
    type:[Object]
    optional:true
  'emails.$.address':
    type:String
    regEx:SimpleSchema.RegEx.Email
  'emails.$.verified':
    type:Boolean
  createdAt:
    type:Date
  services:
    type: Object,
    optional: true,
    blackbox: true
  profile:
    type:Schema.Profile
    optional:true
  roles:
    type:Object
    blackbox:true
    optional:true
