class @TransactionService
  addUpdateSchedule:(schedule)->
    unless schedule._id
      result=Schedules.insert schedule
    else
      result=Schedules.update(schedule._id,$set:schedule)
    result

  addUpdateBids:(bid)->
    unless bid._id
      result= Bids.insert(bid)
    else
      result=Bids.update(bid._id,$set:bid)
    result


