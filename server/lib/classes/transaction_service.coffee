class @TransactionService
  addUpdateSchedule:(schedule)->
    unless schedule._id
      result=Schedules.insert schedule
    else
      result=Schedules.update(schedule._id,$set:schedule)
    result

  addUpdateBids:(bid)->
    schedule=Schedules.findOne(bid.schedule)
    isValid=true
    if schedule.maximumBidPrice
      isValid=schedule.maximumBidPrice>=bid.quote
    if isValid
      unless bid._id
        result= Bids.insert(bid)
      else
        result=Bids.update(bid._id,$set:bid)
      result
    else throw new Meteor.Error('Invalid Quote!',ERROR_BID_QUOTE)


