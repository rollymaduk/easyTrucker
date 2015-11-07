Form.TimeFrame=new SimpleSchema
  context:
    type:String
    allowedValues:['before','after','between','on']
    autoform:
      label:false
      options:{before:'before',after:'after',between:'between',on:'on'}
  dateField_1:
    type:Date
    autoform:
      label:false
      afFieldInput:
        type: 'bootstrap-datetimepicker'
  dateField_2:
    type:Date
    autoform:
      label:false
      afFieldInput:
        type: 'bootstrap-datetimepicker'
    optional:true
    autoValue:->
      field=@siblingField('context')
      condition= not _.isEqual(field.value,'between')
      if(condition and @isSet)
        @unset()
    custom:->
      if(Meteor.isClient)
        field=@siblingField('context')
        condition= _.isEqual(field.value,'between')
        if(condition and not @isSet)
          "required"
        else
          true

