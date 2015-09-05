Schema.Contact=new SimpleSchema
  firstName:
    type:String
  lastName:
    type:String
  gender:
    type:String
    allowedValues:['male','female']
    autoform:
      options:
        [{label:'Male',value:'male'},
          {label:'Female',value:'female'}
        ]
  email:
    type:String
    autoform:
      type:'email'
  company:
    type:String
    optional:true
  position:
    type:String
    optional:true
  phone:
    type:String
    optional:true
  address:
    type:Schema.AddressSchema