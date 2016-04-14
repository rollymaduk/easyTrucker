stripeCheckout=undefined
checkoutAddOptions=undefined
checkoutPlanName=undefined
addPlanCallback=undefined
AppPlans.registerService 'stripe',
  pay:(planName,options,addOptions,callback)->
    unless options then throw Error ('payOptions are required either when defining a plan or when calling add/set')
    console.log "pay method for appPlans Here!"
    check(options, {
      name: String,
      description: Match.Optional(String),
      amount: Number,
      counter: Number
      email: Match.Optional(String),
      currency: Match.Optional(String),
      panelLabel: Match.Optional(String),
      zipCode: Match.Optional(Boolean),
      bitcoin: Match.Optional(Boolean)
    })

    plans=Meteor.user().appPlans?.list
    plan=_.findWhere(plans or [],{planName:planName})
    count=plan?.subscriptionId or 0

    unless count is options.counter
      unless options.email
        options.email=Meteor?.user()?.emails[0]?.address

      checkoutPlanName = planName

      checkoutAddOptions = addOptions

      addPlanCallback = callback;

      stripeCheckout.open(options);

    return

Meteor.startup ->
  if (Meteor.settings && Meteor.settings.public.Stripe && Meteor.settings.public.Stripe.publicKey)
    stripeCheckout = StripeCheckout.configure({
      key: Meteor.settings.public.Stripe.publicKey,
      allowRememberMe: Meteor.settings.public.Stripe.rememberMe || false,
      token:(token)->
        options = _.extend(checkoutAddOptions || {}, {service: 'stripe', token: token.id, email: token.email});
        AppPlans.add(checkoutPlanName, options, (error, result)->
          result = result && {added: result, email: token.email};
          addPlanCallback(error, result)
          return
        )
        return
    })
    return
