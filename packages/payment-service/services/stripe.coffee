Meteor.startup ->
  if (Meteor.settings.Stripe && Meteor.settings.Stripe.secretKey)
    Stripe = StripeAPI(Meteor.settings.Stripe.secretKey)

  Meteor.methods
    "stripe/subscribe":(options)->
      try
        unless @isSimulation
          check(@userId,String)
          check(options,{email:String,metadata:Match.Optional(Object)})
          Stripe.customers.create({email:options?.email,metadata:options?.metadata}).then((customer)->
            customer.id
          ,(err)->throw new Error("Problem subscribing a customer on stripe: #{err}")
          )
        else
          console.log "processing..."
      catch error
        throw new Error "Invalid entry for subscription #{error}"

    "stripe/checkout":(options)->
      try
        unless @isSimulation
          check(@userId,String)
          {description,amount,token}=options
          customer=options?.customer or Meteor.users.findOne(@userId)?.plan?.customerId
          if customer
            currency=options?.currency or pSUtility.defaultCurrency
            Stripe.customers.update(customer,{source:token?.id}).then((card)->
              Stripe.charges.create({customer,currency,description,amount})
            ).then((charge)->
              {status,amount,description}=charge
              {status,amount,description}
            ).then(null,(err)->throw new Error("Problem paying a customer on stripe: #{err}"))
        else console.log "processing..."
      catch error
        throw new Error "Invalid entry for checkout payment #{error}"




    "stripe/pay":(options)->
      try
        unless @isSimulation
          check @userId,String
          {description,amount}=options
          customer=options?.customer or Meteor.users.findOne(@userId)?.plan?.customerId
          if customer
            currency=options?.currency or pSUtility.defaultCurrency
            Stripe.charges.create({customer,currency,description,amount}).then((charge)->
              {status,amount,description}=charge
              {status,amount,description}
            ).then(null,(err)->throw new Error("Problem paying a customer on stripe: #{err}"))
        else console.log "processing..."
      catch error
        throw new Error "Invalid entry for stripe payment #{error}"

    "stripe/addCard":(options)->
      try
        unless @isSimulation
          check @userId,String
          check(options,{source:{exp_month:String,exp_year:String,cvc:String,number:String},customer:Match.Optional(String)})
          {source}=options
          source.object="card" if source
          customer=options?.customer or Meteor.users.findOne(@userId)?.plan?.customerId
          if customer and source
            Stripe.customers.createSource(customer,{source}).then((card)->
              card
            ).then(null,(err)->throw new Error("Problem adding a card on stripe: #{err}"))
        else console.log "processing..."
      catch error
        throw new Error "Invalid entry for stripe card creation #{error}"

    "stripe/removeCard":(options)->
      try
        unless @isSimulation
          check @userId,String
          check(options,{id:String,customer:Match.Optional(String)})
          {id}=options
          customer=options?.customer or Meteor.users.findOne(@userId)?.plan?.customerId
          if customer and id
            Stripe.customers.deleteCard(customer,id).then((response)->
              response.id
            ).then(null,(err)->throw new Error("Problem adding a card on stripe: #{err}"))
        else console.log "processing..."
      catch error
        throw new Error "Invalid entry for stripe card creation #{error}"

    "stripe/changeCard":(options)->
      try
        unless @isSimulation
          check @userId,String
          check(options,{customer:Match.Optional(String),id:String,exp_month:String,exp_year:String})
          {exp_month,exp_year,id}=options
          customer=options?.customer or Meteor.users.findOne(@userId)?.plan?.customerId
          if customer and id
            Stripe.customers.updateCard(customer,id, {exp_month,exp_year}).then((response)->
              {exp_month,exp_year}
            ).then(null,(err)->throw new Error("Problem adding a card on stripe: #{err}"))
        else console.log "processing..."
      catch error
        throw new Error "Invalid entry for stripe card creation #{error}"


