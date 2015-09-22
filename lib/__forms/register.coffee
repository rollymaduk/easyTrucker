Form.RegisterInfoDetail=new SimpleSchema
  companyName:
    type:String
    autoform:
      label:false
      placeholder:'schemaLabel'
  companyAddress:
    type:String
    autoform:
      label:false
      placeholder:'schemaLabel'
  telephoneNumber:
    type:String
    autoform:
      label:false
      placeholder:'schemaLabel'
  truckAuthorityType:
    type:String
    optional:true
    allowedValues:['DOT','FF','MC','MX','NONE']
    defaultValue:'NONE'
    autoform:
      options:{DOT:'DOT',FF:'FF',MC:'MC',MX:'MX',NONE:'NONE'}
  truckAuthorityNumber:
    type:String
    optional:true
    autoform:
      class:'ctrl-visible'
    custom:()->
      if(Meteor.isClient)
        console.log @siblingField('truckAuthorityType')
        condition= ! _.isEqual(@siblingField('truckAuthorityType').value,'NONE')
        if(condition and not @isSet)
          "required"
        else true

Form.RegisterAccountDetail=new SimpleSchema
  accountType:
    type:String
    autoform:
      label:false
      placeholder:'schemaLabel'
  firstname:
    type:String
    autoform:
      label:false
      placeholder:'schemaLabel'
  lastname:
    type:String
    autoform:
      label:false
      placeholder:'schemaLabel'
  email:
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




