Schema.ProfileFormContact=new SimpleSchema
  companyName:
    type:String
    autoform:
      readonly:true
  emails:
    type:[String]
    autoform:
      type:'tags'
  telephones:
    type:[String]
    autoform:
      type:'tags'
  companyAddress:
    type:String

Schema.ProfileFormMetaData=new SimpleSchema
  isActive:
    type:Boolean
    defaultValue:true
    optional:true
    autoform:
      type:'hidden'
      label:false


Schema.ProfileFormDetail=new SimpleSchema
  firstname:
    type:String
  lastname:
    type:String
  bio:
    type:String
    optional:true
    autoform:
      rows:6
  photo:
    type:String
    optional:true
    autoform:
      type:'fileUpload'
      collection:'eZImages'


Schema.Profile=new SimpleSchema([Schema.ProfileFormDetail,Schema.ProfileFormContact
,Schema.ProfileFormMetaData,Form.TruckAuthority
])