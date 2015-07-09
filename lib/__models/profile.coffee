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

Schema.Profile=new SimpleSchema([Schema.ProfileFormDetail,Schema.ProfileFormContact,Schema.ProfileFormMetaData,
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

])