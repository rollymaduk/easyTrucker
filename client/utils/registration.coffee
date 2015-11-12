Eztrucker.Utils.Registration={
  registerUser:(user,role,groupName,callback)->
    if callback
      Meteor.call 'registerNewUser',user,role,groupName,(err,res)->
        if err then callback.call this,err,null else  callback.call this,null,res
    else
      Meteor.call 'registerNewUser',user,role,groupName

  registerNewUser:(user,role,groupName,subscription,callback)->
    console.log user
    subscription=subscription or SUBSCRIBE_FREE
    if _.contains([SUBSCRIBE_FREE,SUBSCRIBE_ANNUAL,SUBSCRIBE_MONTH],subscription)
      unless Meteor.userId()
        AppPlans.set(subscription,{email:user.email},(error)=>
          unless error
            @registerUser(user, role,groupName,callback)
          else
            throw new Meteor.Error 2001,error.message
        )
      else


}