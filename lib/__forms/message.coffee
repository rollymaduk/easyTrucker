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
      if not @isset then new Date
    autoform:
      omit:true
  owner:
    type:String
    autoValue:()->
      if not @isset then Meteor.userId()
    autoform:
      omit:true