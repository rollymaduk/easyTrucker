Schema.ProfileFormContact=new SimpleSchema
  companyName:
    type:String
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
    autoform:
      readonly:true

Schema.ProfileFormMetaData=new SimpleSchema
  trucklatlngBounds:
    type:Schema.LatLngBounds
    optional:true
    autoform:
      type:'hidden'
      label:false
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

Schema.Profile=new SimpleSchema([Schema.ProfileFormDetail,Schema.ProfileFormContact,Schema.ProfileFormMetaData,Form.TruckAuthority])