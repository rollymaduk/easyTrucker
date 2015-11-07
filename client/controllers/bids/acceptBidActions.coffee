Template.acceptBidActions.events
  'click .accept-bid':(evt,temp)->
    Eztrucker.Utils.Payment.checkUserPlan temp.data.schedule._id,->
      Eztrucker.Utils.Schedules.acceptBidAction temp
