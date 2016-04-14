@pSUtility={
  Schemas:{},
  Collections:{}
  defaultCurrency:"usd"
  cardQuery:new ReactiveVar()
  cardMod:new ReactiveVar()
  payQuery:new ReactiveVar()
  payMod:new ReactiveVar()
  validateDefinitions:(options)->
    check(options,[{name:String,isDefault:Boolean,credits:Number,amount:Number,description:Match.Optional(String)}])
  checkOut:(provider,options,callback)->
    if Meteor.isClient
      provider.setClientOptions(options,callback)
      {description,amount}=options
      email=options?.email or Meteor?.user()?.emails[0]?.address
      provider.client.open({description,amount,email})
  STRIPE_CUSTOMER_DELETED:"customer.deleted"
  STRIPE_INVOICE_PAYMENT_SUCCESS:"charge.succeeded"
  STRIPE_CUSTOMER_SOURCE_ADDED:"customer.source.created"
  STRIPE_CUSTOMER_SOURCE_CHANGED:"customer.source.updated"
  STRIPE_CUSTOMER_SOURCE_DELETED:"customer.source.deleted"

}