class @Rp_EntityFactory
  _meteor=undefined
  constructor:(meteor)->
    _meteor=meteor

  createCard:(cardObj={})->
    new Rp_Card(_meteor,pSUtility.Schemas.Card,cardObj)
  createPlan:(planObj={})->
    new Rp_Plan(_meteor,pSUtility.Schemas.Plan,planObj)
  createPayment:(paymentObj={})->
    new Rp_payment(_meteor,pSUtility.Schemas.Payment,paymentObj)

@EntityFactory=new Rp_EntityFactory(Meteor)

