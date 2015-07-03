Meteor.methods
  addUpdateSchedule:(schedule)->
    service= new TransactionService()
    service.addUpdateSchedule(schedule)

  searchSchedules:(pipeline)->
    Schedules.aggregate(pipeline)

  addScheduleComment:(schedule,comment)->
    Form.Message.clean(comment)
    console.log comment
    Schedules.update(schedule,$addToSet:messages:comment)

  updateScheduleTrucker:(schedules,trucker,truck)->
    unless not _.isArray(schedules)

      if schedules.length
        Schedules.update({_id:{$in:schedules},status:{$in:[STATE_MATCHED,STATE_UNMATCHED]},'truckers.owner':trucker}
        ,{$addToSet:'truckers.$.trucks':truck},multi:true)
        Schedules.update({_id:{$in:schedules},status:{$in:[STATE_MATCHED,STATE_UNMATCHED]},$neq:'truckers.owner':trucker}
        ,{$addToSet:truckers:{owner:trucker,trucks:[truck]}},multi:true)
      ###else
        Schedules.update({truckers:trucker,status:STATE_MATCHED},{$pull:{trucks:truck}},multi:true)
###