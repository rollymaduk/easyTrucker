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
    waitOn:->
      handle=Meteor.subscribeWithPagination('trucks',{},10)
      @state.set('subsHandle',handle)
      handle
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
    waitOn:->
      qry=CommonHelpers.getFiltersForTrucks(@params.trucks)
      handle=Meteor.subscribeWithPagination('trucks',qry,10)
      @state.set('subsHandle',handle)
      handle
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
        null
      else
        @render 'home'
        null
    data:->Trucks.findOne(@params._id),
    waitOn:-> Meteor.subscribe('truckItem',{filter:@params._id})
    template:"manageTruck"
  )



  null