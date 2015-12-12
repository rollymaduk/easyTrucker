Meteor.methods
  payAsYouGo:(request,token,email)->
    chargeId=Eztrucker.Utils.Payment.payAsYouGo(token,email)
    group=Roles.getGroupsForUser(@userId)
    Schedules.update(request,$addToSet:charge:{id:chargeId,group:group[0]}) if chargeId
    chargeId


  validateCharge:(request)->
    group=Roles.getGroupsForUser(@userId)
    schedule=Schedules.findOne({_id:request,'charge.group':group[0]})
    chargeId=if schedule then _.findWhere(schedule.charge,{group:group[0]}).id else undefined
    if chargeId then Eztrucker.Utils.Payment.validateCharge(chargeId) else false

  getCustomerCards:(customer)->
    try
      check(customer,String)
      Eztrucker.Utils.Payment.getCustomerCards(customer)
    catch err
      throw new Meteor.Error '7000',err.message

  changeCardDetails:(cardId,customerId,card)->
    try
      check(cardId,String)
      check(customerId,String)
      check(card,Object)
      Eztrucker.Utils.Payment.changeCardDetails(cardId,customerId,card)
    catch err
      throw new Meteor.Error '7001',err.message