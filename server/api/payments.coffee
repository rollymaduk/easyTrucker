Meteor.methods
  payAsYouGo:(request,token,email)->
    chargeId=Eztrucker.Utils.Payment.payAsYouGo(token,email)
    group=Roles.getGroupsForUser(@userId)
    console.log group
    Schedules.update(request,$addToSet:charge:{id:chargeId,group:group[0]}) if chargeId
    chargeId


  validateCharge:(request)->
    group=Roles.getGroupsForUser(@userId)
    console.log group
    schedule=Schedules.findOne({_id:request,'charge.group':group[0]})
    console.log schedule
    chargeId=if schedule then _.findWhere(schedule.charge,{group:group[0]}).id else undefined
    console.log chargeId
    if chargeId then Eztrucker.Utils.Payment.validateCharge(chargeId) else false