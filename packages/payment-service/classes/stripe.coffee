###@flow###
class @Rp_StripeProvider
  description=undefined;amount=undefined;customer=undefined;_callback=undefined;
  constructor:()->
    Meteor.startup =>
      if Meteor.isClient
        check(Meteor.settings.public.Stripe.publicKey, String)
        @client = StripeCheckout.configure({
          key: Meteor.settings.public.Stripe.publicKey
          allowRememberMe: Meteor.settings.public.Stripe.rememberMe || false
          name: Meteor.settings.public.siteName or "Card Payment",
          image:Meteor.absoluteUrl(Meteor?.settings?.public?.logoUrl)
          token: (token)->
            Meteor.call("stripe/checkout",{token,description,amount,customer},(err,res)->
              console.log {token,description,amount,customer}
              console.log err or res
              _callback.call @,err,res if _callback
            )
            return
        });
        return

  setClientOptions:(options,callback)->
    {description,amount,customer}=options
    _callback=callback


  subscribe:(options,callback)->
    Meteor.call('stripe/subscribe',options,(err,res)->
      callback.call null,err,res if callback
      return
    )
    return

  pay:(options,callback)->
    Meteor.call('stripe/pay',options,(err,res)->
      callback.call null,err,res if callback
      return
    )
    return

  addCard:(options,callback)->
    Meteor.call('stripe/addCard',options,(err,res)->
      callback.call null,err,res if callback
      return
    )

  changeCard:(options,callback)->
    Meteor.call('stripe/changeCard',options,(err,res)->
      callback.call null,err,res if callback
      return
    )

  removeCard:(options,callback)->
    Meteor.call('stripe/removeCard',options,(err,res)->
      callback.call null,err,res if callback
      return
    )


@StripeProvider =new Rp_StripeProvider()