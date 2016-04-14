Eztrucker.Utils.Registration={
  registerUser:(user,role,groupName,callback)->
    Meteor.call 'registerNewUser',user,role,groupName,(err,res)->
     callback.call @,err,res if callback

  registerNewUser:(user,role,groupName,subscription,callback)->
    if Meteor?.settings?.paymentPlans?.length
      subscription=subscription or _.findWhere(Meteor.settings.paymentPlans,{isDefault:true})?.name
      unless Meteor.userId()
        @registerUser(user, role,groupName,(err,res)->
          Rp_Payment.subscribe(subscription,{metadata:{userId:res}},(err,res)->
            console.log err or res
            callback.call @,err,res if callback
          )
        )

}