class @UserAccountService
  registerNewUser:(user, role,groupName,callback)->
    console.log user
    Meteor.call 'registerNewUser',user,role,groupName,(err,res)->
      if callback then callback.call @,err,res
      null
    null
  updateUserProfile:(userId,profile,callback)->
    Meteor.call 'updateUserProfile',userId,profile,(err,res)->
      if callback then callback.call @,err,res
      null
    null

