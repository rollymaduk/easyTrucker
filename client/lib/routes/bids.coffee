Router.map ()->
  @route('bidList',
    path:'/app/bids/list/:_id'
    data:()->Bids.find({schedule:@params._id})
    waitOn:()->
      Meteor.subscribe('bids',{schedule:@params._id})
  )

  @route('bidDetail',
    path:'/app/bids/view/:_id'
    data:->
      Bids.findOne(@params._id)
    waitOn:->
      Meteor.subscribe('bidItem',@params._id)
    template:"bidDetail"
  )

  @route('editBid',
    path:'/app/bids/edit/:_id',
    onBeforeAction:()->
      if RP_permissions.hasPermissions(['canEditbid','canManagebid'])
        @next()
        null
      else
        @render 'home'
        null
    data:->Bids.findOne(@params._id),
    waitOn:->Meteor.subscribe('bids',@params._id)
    template:"manageBid")

  @route('newBid',
    path:'/app/bids/new/:_id'
    data:->
      schedule=Schedules.findOne(@params._id)
      if schedule
        {scheduleItem:schedule,schedule:schedule._id,proposedPickup:schedule.pickupDate,proposedDelivery:schedule.dropOffDate}
    onBeforeAction:()->
      if RP_permissions.hasPermissions(['canCreatebid','canManagebid'])
        @next()
        null
      else
        @render 'home'
        null
    waitOn:->Meteor.subscribe('scheduleItem',@params._id)
    template:"manageBid")

  null