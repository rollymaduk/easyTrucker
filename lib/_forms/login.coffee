Form.Login=new SimpleSchema
  username:
    type:String
    autoform:
      label:false
      placeholder:'Username or Email'
  password:
    type:String
    autoform:
      type:'password'
      label:false
      placeholder:'schemaLabel'

@loginSchemaContext=Form.Login.namedContext('loginForm')