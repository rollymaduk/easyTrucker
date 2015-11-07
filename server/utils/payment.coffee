if (Meteor.settings.Stripe && Meteor.settings.Stripe.secretKey)
  Stripe = StripeAPI(Meteor.settings.Stripe.secretKey);
Eztrucker.Utils.Payment={
  payAsYouGo:(token,email)->
    try

      check(Meteor.settings.public.Stripe.payAsYouGoCharge,Number)
      chargeSync=Meteor.wrapAsync(Stripe.charges.create,Stripe.charges)
      charge=chargeSync({amount:Meteor.settings.public.Stripe.payAsYouGoCharge,currency:"usd"
        ,receipt_email:email,description:"Eazytrucker transaction fee",source:token.id})
      charge.id
    catch err
      throw new Meteor.Error("6005",err.message)

  validateCharge:(chargeId)->
    try
      check(chargeId,String)
      retrieveChargeSync=Meteor.wrapAsync(Stripe.charges.retrieve,Stripe.charges)
      charge=retrieveChargeSync(chargeId)
      charge.id is chargeId
    catch err
      throw new Meteor.Error("6006",err.message)
}
