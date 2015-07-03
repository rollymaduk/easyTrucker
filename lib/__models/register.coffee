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



Form.TruckAuthority=new SimpleSchema
  truckAuthState:
    type:String
    optional:true
    autoform:
      type:'hidden'
      label:false
  truckAuthorityType:
    type:String
    optional:true
    custom:()->
      if(Meteor.isClient)
        condition=  _.isEmpty(@field('truckAuthState').value) or @field('truckAuthState').value is 'NONE'
        if(condition and not @isSet and (not @operator or @value is null or _.isEmpty(@value)))
          "required"
        else true
    allowedValues:['DOT','FF','MC','MX','NONE']
    autoform:
      options:{DOT:'DOT',FF:'FF',MC:'MC',MX:'MX',NONE:'NONE'}
  truckAuthorityNumber:
    type:String
    optional:true
    custom:()->
      if(Meteor.isClient)
        condition=  _.isEmpty(@field('truckAuthState').value) or @field('truckAuthState').value is 'NONE'
        if(condition and not @isSet and (not @operator or @value is null or _.isEmpty(@value)))
          "required"
        else true







###Form.Register=new SimpleSchema [Form.RegisterAccountDetails,Form.RegisterInfoDetails,Form.RegisterTransportLicence]###




