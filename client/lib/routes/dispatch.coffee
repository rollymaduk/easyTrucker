Router.map ()->
  @route('manageDispatch'
    path:'dispatch/:_id/:shipmentTitle',
    onBeforeAction:()->
      if RP_permissions.hasPermissions(['canDispatchLoad'])
        @next()
      else
        @render "home"
        null
    template:"manageDispatch"
    data:->
      dispatch=Dispatches.findOne({schedule:@params._id}) or {schedule:@params._id}
      _.extend(dispatch,{shipmentTitle:@params.shipmentTitle})
    waitOn:->
      Meteor.subscribe('dispatches',{schedule:@params._id})
  )