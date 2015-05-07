Schema.ProfileFormContact=new SimpleSchema
  emails:
    type:[String]
    optional:true
    autoform:
      type:'tags'
  telephones:
    type:[String]
    optional:true
    autoform:
      type:'tags'
  addresses:
    optional:true
    type:[SimpleSchema.AddressSchema]

Schema.ProfileFormDetail=new SimpleSchema
  name:
    type:String
    optional:true
  gender:
    type:String
    optional:true
    allowedValues:['male','female','none']
    autoform:
      options:{male:'male',female:'female',none:'none'}
  bio:
    type:String
    optional:true
    autoform:
      rows:6

Schema.Profile=new SimpleSchema([Schema.ProfileFormDetail,Schema.ProfileFormContact])