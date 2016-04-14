class @Rp_Plan
  _meteor=undefined ;_validator=undefined;

  constructor:(meteor,validator,plan={})->
    _validator=validator
    _meteor=meteor
    _validator.clean(plan)
    {@credit,@name,@payWithCard,@customerId}=plan

  add:(query,isTrustedCode,callback)->
    _plan={@credit,@name,@payWithCard,@customerId}
    _meteor.call('plan/add',_plan,query,isTrustedCode,(err,res)->
      console.log err or res
      callback.call @,err,res if callback
    )

  change:(query,isTrustedCode,callback)->@add(query,isTrustedCode,callback)

  remove:(query,isTrustedCode,callback)->
    _meteor.call('plan/remove',query,isTrustedCode,(err,res)->
      console.log err or res
      callback.call @,err,res if callback
    )

  rechargeUnits:(units,query,isTrustedCode,callback)->
    @credit=@credit+units
    @add(query,isTrustedCode,callback)

  togglePayWithCard:(mode,query,isTrustedCode,callback)->
    @payWithCard=mode
    @add(query,isTrustedCode,callback)


class @Rp_PlanProvider
  _meteor=undefined
  constructor:(meteor)->
    _meteor=meteor

  getPlan:(query)->
    query=query or _meteor.userId()
    _meteor.users.findOne(query)?.plan

  confirm:()->
    @getPlan()?.credit > 0


@PlanProvider=new Rp_PlanProvider(Meteor)