Router.map ()->
  @route('bidList',
    path:'/app/bids/:_id'
    data:()->
      Bids.find({schedule:@params._id})
    waitOn:()->
      Meteor.subscribe('bidList',@params._id)
  )

  @route('viewBid',
    path:'/app/schedules/bid/:_id',
    data:->Schedules.findOne(@params.schedule),
    waitOn:->Meteor.subscribe('scheduleItem',@params.schedule,@params.owner)
    template:"scheduleDetail"
  )