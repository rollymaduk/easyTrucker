ProcessDeliveryTask = (item)->
  if Meteor.isServer
    state = if item.hasIssue then STATE_ISSUE else STATE_SUCCESS
    schedule=Schedules.findOne(item.schedule);
    Meteor.call "updateSchedule",schedule._id,{$set:{status: state,nextStep:"feedBack"}},(err,res)->
      Ratings.insert({schedule:item.schedule,owner:schedule.winningBid.bidder,child:schedule.resource.driver})
      Ratings.insert({schedule:item.schedule,owner:schedule.owner})
Deliveries.after.insert (user,doc)->
  ProcessDeliveryTask(doc)
Deliveries.after.update (user,doc,fieldnames,mod,options)->
  item=@previous
  ProcessDeliveryTask(_.extend(doc,mod.$set))

