class @UserAccountService
  registerNewUser:(user, role,callback)->
    Meteor.call 'registerNewUser',user,role,(err,res)->
      if callback then callback.call @,err,res
      null
    null
  updateUserProfile:(userId,profile,callback)->
    Meteor.call 'updateUserProfile',userId,profile,(err,res)->
      if callback then callback.call @,err,res
      null
    null

