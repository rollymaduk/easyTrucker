class @UserAccountService
  registerNewUser:(user, role,callback)->
    Meteor.call 'registerNewUser',user,role,(err,res)->
      if err then throw new Meteor.Error err
      if callback then callback.call @,res
      null
    null
  updateUserProfile:(userId,profile,callback)->
    Meteor.call 'updateUserProfile',userId,profile,(err,res)->
      if err then throw new Meteor.Error err
      if callback then callback.call @,res
      null
    null

