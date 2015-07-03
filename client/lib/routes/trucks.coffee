Router.map ()->
  @route('truckList',
    path:'/app/truckList'
    onBeforeAction:()->
      if RP_permissions.hasPermissions(['canViewTruck','canManageTruck'])
        @next()
        null
      else
        @render 'home'
        null

    data:->Trucks.find()
    waitOn:->Meteor.subscribe('truckList',50))

  @route('addTruck',
    path:'/app/truck/new'
    onBeforeAction:()->
      if RP_permissions.hasPermissions(['canCreateTruck','canManageTruck'])
        @next()
        null
      else
        @render 'home'
        null
    template:"manageTruck"
  )

  @route('editTruck',
    path:'/app/truck/edit/:_id'
    onBeforeAction:()->
      if RP_permissions.hasPermissions(['canEditTruck','canManageTruck'])
        @next()
        null
      else
        @render 'home'
        null
    data:->Trucks.findOne(@params._id),
    waitOn:-> Meteor.subscribe('truckItem',@params._id)
    template:"manageTruck"
  )
  null