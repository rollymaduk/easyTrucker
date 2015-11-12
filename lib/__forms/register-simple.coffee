Form.RegisterSimple=new SimpleSchema
  accountType:
    label:"Account Type"
    type:String
    allowedValues:[ROLE_TRUCKER,ROLE_SHIPPER]
    autoform:
      options:'allowed'
      label:false
      placeholder:'schemaLabel'
  fullName:
    type:String
    autoform:
      label:false
      placeholder:'schemaLabel'
  email:
    type:String
    autoform:
      type:'email'
      label:false
      placeholder:'schemaLabel'


