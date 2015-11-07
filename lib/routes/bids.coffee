Router.map ()->
  @route('bidList',
    path:'/bids/list/:_id'
    data:()->Bids.find({'schedule._id':@params._id})
    waitOn:()->
      Meteor.subscribe('bids',{'schedule._id':@params._id})
  )

  @route('bidDetail',
    path:'/bids/view/:_id'
    data:->
      Bids.findOne(@params._id)
    waitOn:->
      Meteor.subscribe('bids',@params._id)
    template:"bidDetail"
  )

  @route('bidDetailBySchedule',
    path:'/bids/view/schedule/:_id/:bidder'
    data:->
      Bids.findOne({'schedule._id':@params._id,owner:@params.bidder})
    waitOn:->
      Meteor.subscribe('bids',{'schedule._id':@params._id,owner:@params.bidder})
    template:"bidDetail"
  )

  @route('editBid',
    path:'/bids/edit/:_id',
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
    path:'/bids/new/:_id'
    data:->
      schedule=Schedules.findOne(@params._id)
      if schedule
        {schedule:_.pick(schedule,'_id','owner','pickupDate','dropOffDate','shipmentTitle','maximumBidPrice')}
    onBeforeAction:()->
      if RP_permissions.hasPermissions(['canCreatebid','canManagebid'])
        @next()
        null
      else
        @render 'home'
        null
    waitOn:->Meteor.subscribe('schedules',filter:_id:@params._id)
    template:"manageBid")
  null