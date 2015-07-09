Router.map ()->
  @route('bidList',
    path:'/app/bids/:_id'
    data:()->
      Bids.find({schedule:@params._id})
    waitOn:()->
      Meteor.subscribe('bidList',@params._id)
  )

  @route('bidDetail',
    path:'/app/bids/view/:_id'
    data:->Bids.findOne(@params._id)
    waitOn:->Meteor.subscribe('bidItem',@params._id)
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
    waitOn:->Meteor.subscribe('bidItem',@params._id)
    template:"manageBid")

  @route('newBid',
    path:'/app/bids/:shipmentTitle/new/:_id'
    data:->{schedule:@params._id,shipmentTitle:@params.shipmentTitle}
    onBeforeAction:()->
      if RP_permissions.hasPermissions(['canCreatebid','canManagebid'])
        @next()
        null
      else
        @render 'home'
        null
    template:"manageBid")

  null