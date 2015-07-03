Schema.Activity=new SimpleSchema
  isNew:
    type:Boolean
    defaultValue:true
  parentId:
    type:String
    optional:true
  objectId:
    type:String
  message:
    type:String
    max:250
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

