Form.RegisterInfoDetail=new SimpleSchema
  accountType:
    type:String
    allowedValues:[ACCOUNT_INDIVIDUAL,ACCOUNT_GROUP]
    autoform:
      options:"allowed"
  companyName:
    type:String
    optional:true
    autoform:
      label:false
      placeholder:'schemaLabel'
    custom:()->
      if(Meteor.isClient)
        console.log @siblingField('accountType')
        condition= ! _.isEqual(@siblingField('accountType').value,ACCOUNT_GROUP)
        if(condition and not @isSet)
          "required"
        else true
  companyAddress:
    type:String
    optional:true
    autoform:
      label:false
      placeholder:'schemaLabel'
    custom:()->
      if(Meteor.isClient)
        console.log @siblingField('accountType')
        condition= ! _.isEqual(@siblingField('accountType').value,ACCOUNT_GROUP)
        if(condition and not @isSet)
          "required"
        else true
  telephoneNumber:
    type:String
    autoform:
      label:false
      placeholder:'schemaLabel'






Form.RegisterAccountLoginDetail=new SimpleSchema
  username:
    type:String
    autoform:
      label:false
      placeholder:'schemaLabel'
  password:
    type:String
    min:8
    autoform:
      type:'password'
      label:false
      placeholder:'schemaLabel'
  repeatPassword:
    type:String
    min:8
    custom:()->
      if this.value isnt this.field('password').value
        "passwordMismatch";
    autoform:
      type:'password'
      label:false
      placeholder:'schemaLabel'



@RegisterAccountDetailContext=Form.RegisterAccountDetail.namedContext('regAcctDetailForm')
@RegisterAccountLoginDetailContext=Form.RegisterAccountLoginDetail.namedContext('regAccountLoginDetailForm')





###Form.Register=new SimpleSchema [Form.RegisterAccountDetails,Form.RegisterInfoDetails,Form.RegisterTransportLicence]###




