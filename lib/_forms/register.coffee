Form.Register=new SimpleSchema
  accountType:
    type:String
    allowedValues:['shipper','trucker']
    autoform:
      options:{shipper:'Shipper',trucker:'Trucker'}
      label:false
      placeholder:'schemaLabel'
  username:
    type:String
    autoform:
      label:false
      placeholder:'schemaLabel'
  password:
    type: String
    min: 8
    autoform:
      type:'password'
      label:false
      placeholder:'Enter a password'
  confirmPassword:
    type: String
    min: 8
    autoform:
      type:'password'
      label:false
      placeholder:'Enter the password again'
    custom:()->
      if this.value isnt this.field('password').value
        "passwordMismatch";
  email:
    type:String
    autoform:
      label:false
      placeholder:'schemaLabel'

