class @TransactionService
  addUpdateSchedule:(schedule)->
    unless schedule._id
      result=Schedules.insert schedule
      routeParam=_id:result
      message=NotifyMessage.newRequest
    else
      result=Schedules.update(schedule._id,$set:schedule)
      routeParam=_id:schedule._id
      message=NotifyMessage.updateRequest
    unless not routeParam
      notification={}
      Schema.Activity.clean(notification)
      notification={message:message,route:{name:'viewSchedule',param:routeParam}
        ,audience:schedule.truckers,tag:'schedule'}
      Activities.insert(notification)
    result

  addUpdateBids:(bid)->
    unless bid._id
      result= Bids.insert(bid)
      routeParam=_id:result
      message=NotifyMessage.newBid
    else
      result=Bids.update(bid._id,$set:bid)
      routeParam=_id:bid._id
      message=NotifyMessage.updateBid
    unless not routeParam
      schedule=Schedules.findOne(bid.schedule)
      notification={}
      Schema.Activity.clean(notification)
      notification={message:message,route:{name:'viewBid',param:routeParam}
        ,audience:[schedule.owner],tag:'bid'}
      Activities.insert(notification)
    result


