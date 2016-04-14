pSUtility.Schemas.Card=new SimpleSchema
  id:
    type:String
  isDefault:
    type:Boolean
    optional:true
    defaultValue:false
  last4:
    type:String
  exp_year:
    type:String
  exp_month:
    type:String
  customer:
    type:String
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


pSUtility.Collections.Cards=new Meteor.Collection('rp_credit_cards')
pSUtility.Collections.Cards.attachSchema pSUtility.Schemas.Card

if Meteor.isServer
  Meteor.publish('rp_credit_cards',(qry={},modifier={})->
    modifier['limit']=50
    if @userId
      pSUtility.Collections.Cards.find(qry,modifier)
  )

if Meteor.isClient
  Tracker.autorun ->
    Meteor.subscribe('rp_credit_cards',pSUtility.cardQuery.get(),pSUtility.cardMod.get())
