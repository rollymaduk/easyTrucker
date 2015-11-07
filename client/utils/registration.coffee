Eztrucker.Utils.Registration={
  registerNewUser:(user, role,groupName,subscription,callback)->
    subscription=subscription or SUBSCRIBE_FREE
    if _.contains([SUBSCRIBE_FREE,SUBSCRIBE_ANNUAL,SUBSCRIBE_MONTH],subscription)
      AppPlans.set(subscription,{email:user.email},(error)->
        unless error
          if callback
            Meteor.call 'registerNewUser',user,role,groupName,(err,res)->
             if err then callback.call this,err,null else  callback.call this,null,res
          else
            Meteor.call 'registerNewUser',user,role,groupName
        else
          throw new Meteor.Error 2001,error.message
      )

}