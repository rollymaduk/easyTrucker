Schema.ProfileFormContact=new SimpleSchema
  accountType:
    type:String
    optional:true
    allowedValues:[ACCOUNT_GROUP,ACCOUNT_INDIVIDUAL]
    autoform:
      options:"allowed"
  companyName:
    type:String
    defaultValue:TEXT_NONE
    custom: ->
      if @field("accountType").value is ACCOUNT_GROUP and !@isSet
        "required"
      else undefined
    autoform:
      readonly:true
  emails:
    type:[String]
    optional:true
    autoform:
      type:'tags'
  referredBy:
    type:String
    optional:true
    autoform:
      readonly:true
  telephones:
    type:[String]
    defaultValue:[]
    custom: ->
      if _.contains([ACCOUNT_GROUP,ACCOUNT_INDIVIDUAL],@field("accountType").value) and @value.length<1
          "required"
      else undefined
    autoform:
      type:'tags'
  companyAddress:
    defaultValue:TEXT_NONE
    custom: ->
      if @field("accountType").value is ACCOUNT_GROUP and !@isSet
        "required"
      else undefined
    type:String
    autoform:
      readonly:true
  truckAuthorityType:
    type:String
    optional:true
    allowedValues:['DOT','FF','MC','MX',TEXT_NONE]
    defaultValue:TEXT_NONE
    autoform:
      options:{DOT:'DOT',FF:'FF',MC:'MC',MX:'MX',None:TEXT_NONE}
  truckAuthorityNumber:
    type:String
    optional:true
    custom:()->
      if(Meteor.isClient)
        console.log @siblingField('truckAuthorityType')
        condition= ! _.isEqual(@siblingField('truckAuthorityType').value,TEXT_NONE)
        if(condition and not @isSet)
          "required"
        else true


Schema.ProfileFormMetaData=new SimpleSchema
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
  photo:
    type:String
    optional:true
    autoform:
      type:"uploadCare"
      uc_options:
        'data-multiple':false
        'classStyle':'uploader-green-button'




Schema.Profile=new SimpleSchema([Schema.ProfileFormDetail,Schema.ProfileFormContact,Schema.ProfileFormMetaData])

Form.RegisterAccountDetail=new SimpleSchema
  userType:
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