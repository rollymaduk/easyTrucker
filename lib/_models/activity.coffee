Schema.Activity=new SimpleSchema
  isMessage:
    type:Boolean
    defaultValue:false
  isNew:
    type:Boolean
    defaultValue:true
  message:
    type:String
    max:250
  route:
    type:Object
    optional:true
  'route.name':
    type:String
  'route.param':
    type:Object
    optional:true
    blackbox:true
  tag:
    type:String

  createdAt:
    type:Date
    autoValue:()->
      if @isInsert then new Date;
      else if @isUpsert then $setOnInsert:new Date
      else @unset()
  owner:
    type:String
    autoValue:()->
      if @isInsert then Meteor.userId()
      else if @isUpsert then $setOnInsert:Meteor.userId()
      else @unset()
  audience:
    type:[String]
    minCount:1

