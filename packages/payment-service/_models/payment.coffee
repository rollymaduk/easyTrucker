pSUtility.Schemas.Payment=new SimpleSchema
  id:
    type:String
  customer:
    type:String
  amount:
    type:Number
  date:
    type:Date
    defaultValue:new Date()
  status:
    type:String
  description:
    type:String
    optional:true
  owner:
    type:String
    autoValue:()->
      if @isFromTrustedCode
        customer=@field("customer").value
        userId=Meteor.users.findOne({"plan.customerId":customer})._id
      else userId=@userId
      if @isInsert
        userId
      else if @isUpsert then $setOnInsert:userId
      else @unset()

pSUtility.Collections.Payments=new Meteor.Collection('rp_credit_payments')
pSUtility.Collections['Payments'].attachSchema pSUtility.Schemas.Payment

if Meteor.isServer
  Meteor.publish('rp_credit_payments',(qry={},modifier={})->
    modifier['limit']=50
    qry['owner']=@userId
    if @userId
      pSUtility.Collections.Payments.find(qry,modifier)
  )

if Meteor.isClient
  Tracker.autorun ->
    Meteor.subscribe('rp_credit_payments',pSUtility.payQuery.get(),pSUtility.payMod.get())