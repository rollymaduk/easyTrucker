
Eztrucker.Utils.Payment= {
  configure: (requestId,callback)->
    try
      check(Meteor.settings.public.Stripe.payAsYouGoCharge, Number)
      check(Meteor.settings.public.Stripe.publicKey, String)
      StripeCheckout.configure(
        key: Meteor.settings.public.Stripe.publicKey
        allowRememberMe: Meteor.settings.public.Stripe.rememberMe || false
        token: (token)->
          Meteor.call 'payAsYouGo',requestId,token, Meteor.user().emails[0].address,(err, res)->
            unless err
              if callback then callback.call null
            else console.log err or res
      )
    catch err
      throw new Meteor.Error(err.index, err.message)
  pay: (requestId,email,callback)->
      try
        check(requestId,String)
        check(email,String)
        handle=@configure(requestId,callback)
        if handle
          check(Meteor.settings.public.Stripe.payAsYouGoCharge, Number)
          handle.open(
            {
              name: "EazyTrucker.com"
              email: email
              amount: Meteor.settings.public.Stripe.payAsYouGoCharge
            }
          )
        else throw new Meteor.Error('6001', "stripe handle does not exist")
      catch err
        throw new Meteor.Error(err.index, err.message)

  checkUserPlan:(request,callback)->
    plan=AppPlans.get() or SUBSCRIBE_FREE
    if plan is SUBSCRIBE_FREE
      Meteor.call 'validateCharge',request,(err,res)->
        console.log err or res
        unless err
          unless res then Modal.show 'payAsYouGoModal',request
          else callback.call this
        else
          console.log err
    else
      callback.call this

  getCustomerCards:(customerId,callback)->
    Meteor.call 'getCustomerCards',customerId,(err,res)->
      callback.call null,err,res


}