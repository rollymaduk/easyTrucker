Form.RegisterSimple=new SimpleSchema
  accountType:
    label:"Account Type"
    type:String
    allowedValues:[ROLE_TRUCKER,ROLE_SHIPPER]
    autoform:
      options:'allowed'
  fullName:
    type:String
  email:
    type:String
    autoform:
      type:'email'
  referredBy:
    type:String
    optional:true




