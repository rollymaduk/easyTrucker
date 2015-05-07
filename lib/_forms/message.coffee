Form.Message=new SimpleSchema
  message:
    type:String
    autoform:
      label:false
      placeholder:"schemaLabel"
      rows:3
  createdAt:
    type:Date
    autoValue:()->
      if @isInsert then new Date;
      else if @isUpsert then $setOnInsert:new Date
      else @unset()
    autoform:
      type:'hidden'
      label:false
  owner:
    type:String
    autoValue:()->
      if @isInsert then Meteor.userId()
      else if @isUpsert then $setOnInsert:Meteor.userId()
      else @unset()
    autoform:
      type:'hidden'
      label:false