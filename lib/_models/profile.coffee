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

Schema.Profile=new SimpleSchema([Schema.ProfileFormDetail,Schema.ProfileFormContact,Form.TruckAuthority])