Router.map ()->
  @route('manageDelivery'
    path:'delivery/:_id/:shipmentTitle',
    onBeforeAction:()->
      if RP_permissions.hasPermissions(['canCloseRequest'])
        @next()
      else
        @render "home"
        null
    template:"manageDelivery"
    data:->
      delivery=Deliveries.findOne({schedule:@params._id}) or {schedule:@params._id}
      _.extend(delivery,{shipmentTitle:@params.shipmentTitle})
    waitOn:->
      Meteor.subscribe('deliveries',{schedule:@params._id})
  )

  @route('deliveryDetail'
    path:'delivery_detail/:_id',
    onBeforeAction:()->
      if RP_permissions.hasPermissions(['canGiveFeedback'])
        @next()
      else
        @render "home"
        null
    template:"deliveryDetail"
    data:->
      Deliveries.findOne({schedule:@params._id})
    waitOn:->
      Meteor.subscribe('deliveries',{schedule:@params._id})
  )
