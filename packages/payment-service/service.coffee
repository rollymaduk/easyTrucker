class @Rp_StripeService extends IService
  _factory=undefined
  _paymentPrv=undefined
  _planPrv=undefined
  _cardPrv=undefined
  _stripePrv=undefined
  _utility=undefined
  _router=undefined
  _meteor=undefined
  _definitions=undefined
  _that=undefined

  constructor:(providers,utility,router,meteor)->
    _factory=providers.EntityFactory
    _cardPrv=providers.CardProvider
    _planPrv=providers.PlanProvider
    _paymentPrv=providers.PaymentProvider
    _stripePrv=providers.StripeProvider
    _utility=utility
    _router=router
    _meteor=meteor
    _that=@

    if _meteor?.isServer
      if _router
        ###bodyParser=_utility.getBodyParser()
        _router.middleware(bodyParser.urlencoded({ extended: false }))
        _router.middleware(bodyParser.json())###
        _router.route('/webhooks/stripe',()->
          request=@request.body
          switch request?.type
            when _utility.STRIPE_CUSTOMER_DELETED
              _plan=_planPrv.getPlan({'plan.customerId':data?.object?.id})
              if _plan and request?.data?.object?.id is _plan.customerId
                _plan.remove()
            when _utility.STRIPE_CUSTOMER_SOURCE_DELETED
              ###use customer id to track card###
              _card=_cardPrv.getCard(request?.data?.object?.id)
              if _card then _factory.createCard(_card).remove(true)
            when _utility.STRIPE_CUSTOMER_SOURCE_ADDED
              ###set card owner to customer id###
              if request?.data?.object?.id
                {id,last4,exp_year,exp_month,customer}=request.data.object
                _card=_factory.createCard({id,last4,exp_year,exp_month,customer})
                _card.add(true)
            when _utility.STRIPE_CUSTOMER_SOURCE_CHANGED
              ###use customer id to track card###
              _card=_cardPrv.getCard(request?.data?.object?.id)
              if _card
                {exp_year,exp_month}=request?.data?.object
                card=_.extend(_card,{exp_year,exp_month})
                _factory.createCard(card).change(true)

            when _utility.STRIPE_INVOICE_PAYMENT_SUCCESS
              if request?.data?.object?.id
                {id,customer,amount,status,description}= request?.data?.object
                _factory.createPayment({id,customer,amount,status,description}).add(true)

            else
          @response.statusCode=200
          @response.end("done")
        ,{where: 'server'}
        )

  setPlanDefinitions:(options)->
    _utility.validateDefinitions(options)
    _definitions=options
    return true

  getPlanDefinitions:()->
    _utility.validateDefinitions(_definitions)
    _definitions

  getPlanDefinition:(name)->
    _.findWhere(@getPlanDefinitions(),{name:name})

  setPayWithCard:(mode,callback)->
    _plan=@currentPlan()
    _factory.createPlan(_plan).togglePayWithCard(mode,null,null,callback) if _plan


  changePlan:(name,callback)->
    definition=@getPlanDefinition(name)
    _plan=@currentPlan()
    if _plan
      _plan.name=definition.name
      _factory.createPlan(_plan).change(null,null,callback)

  rechargeUnits:(qry,isTrustedCode)->
    if _meteor.isServer
      _plan=@currentPlan(qry)
      _factory.createPlan(_plan).rechargeUnits(@getPlanDefinition(_plan.name)?.credits or 0,qry,isTrustedCode) if _plan
    else console.log("Can only recharge on server!")

  _rechargeUnits=(plan,credit)->
    _factory.createPlan(plan).rechargeUnits(credit)


  cards:(query={},modify={})->_cardPrv?.getCards(query,modify)

  currentPlan:(qry)->_planPrv?.getPlan(qry)

  serviceName:"STRIPE"

  credits:()->@currentPlan().credit

  payments:(query={},modify={})->
    _paymentPrv?.getPayments(query,modify)

  subscribe:(name,options,callback)->
    unless @currentPlan()
      definition=@getPlanDefinition(name)
      if definition
        _stripePrv?.subscribe(options,(err,res)->
          console.log err or res
          unless err
            plan=_factory?.createPlan({name:definition?.name,customerId:res})
            plan.add()
            callback.call @,err,res if callback
        )

  setCreditCount:(count,qry)->
    if _meteor.isServer
      count=count or 1
      _plan=@currentPlan(qry)
      _plan.credit=_plan.credit-count
      plan=_factory?.createPlan(_plan)
      plan.add()
    else
      console.log "Can only set credit count on server"


  pay:(options,callback)->
    unless _planPrv.confirm()
      _plan=@currentPlan()
      _credits=@getPlanDefinition(_plan.name)?.credits
      options=options or {description,amount}=@getPlanDefinition(_plan?.name)
      if _plan.payWithCard
        _stripePrv?.pay(options,(err,res)->
          unless err
            console.log res
            _rechargeUnits(_plan,_credits)
            callback.call @,null,res if callback
          else
            console.log err
            _utility.checkOut(_stripePrv,options,(err,res)->
              _rechargeUnits(_plan,_credits)
              callback.call @,err,res if callback
            )
        )
      else
        _utility.checkOut(_stripePrv,options,(err,res)->
          _rechargeUnits(_plan,_credits)
          callback.call @,err,res if callback
        )
    else
      callback.call @,null,true if callback

      

  removeCard:(options,callback)->
    _stripePrv?.removeCard(options,(err,res)->
      console.log err or res
      callback.call @,err,res if callback
    )


  addCard:(options,callback)->
    _stripePrv?.addCard(options,(err,res)->
      console.log err or res
      callback.call @,err,res if callback
    )


  changeCard:(options,callback)->
    _stripePrv?.changeCard(options,(err,res)->
      console.log err or res
      callback.call @,err,res if callback
    )



providers={PaymentProvider,PlanProvider,CardProvider,EntityFactory,StripeProvider}
Rp_Payment=new Rp_StripeService(providers,pSUtility,Router,Meteor)
