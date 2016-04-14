Template.acceptBidActions.events
  'click .accept-bid':(evt,temp)->
    Eztrucker.Utils.Payment.checkUserPlan (err,res)->
      console.log err or res
      Eztrucker.Utils.Schedules.acceptBidAction temp.data.bid if res
      return
    return
