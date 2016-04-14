Router.map ()->
  @route('truckList',
    path:'/truckList'
    onBeforeAction:()->
      if RP_permissions.hasPermissions(['canViewTruck','canManageTruck'])
        @next()
        null
      else
        @render 'home'
        null
    data:->
      Trucks.find()

  )

  @route('filteredTruckList',
    path:'/filteredTrucks/:trucks'
    template:'truckList'
    onBeforeAction:()->
      if RP_permissions.hasPermissions(['canViewTruck','canManageTruck'])
        Session.set('assignMode',@params.hash)
        @next()
        null
      else
        @render 'home'
        null
    onStop:->
      if Session.get('assignMode') then Session.set('assignMode',undefined)
    data:->
      Trucks.find()

  )

  @route('addTruck',
    path:'/truck/new'
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
    path:'/truck/edit/:_id'
    onBeforeAction:()->
      if RP_permissions.hasPermissions(['canEditTruck','canManageTruck'])
        @next()
        return
      else
        @render 'home'
        return
    data:->Trucks.findOne(@params._id),
    waitOn:-> Meteor.subscribe('truckItem',@params._id)
    template:"manageTruck"
  )

  @route('viewTruck',
    path:'/truck/view/:_id',
    data:->Trucks.findOne(@params._id),
    onBeforeAction:()->
      if RP_permissions.hasPermissions(['canViewTruck','canManageTruck'])
        @next()
        null
      else
        @render 'home'
        null
    waitOn:->
      Meteor.userId()
      Meteor.subscribe('truckItem',@params._id)
    template:"truckDetail"
  )

  return