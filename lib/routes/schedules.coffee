###hacky method to get filters for load requests based on the url hash value as field name or using d
  default status from helper library###
getFilter=(value,field)->
  unless field
    CommonHelpers.getFiltersForSchedule(value)
  else
    CommonHelpers.buildFilterQry([{field:field,value:value?.split(',') or [],operator:'$in'}])

Router.map ()->
  @route('scheduleList',
    path:'/loads'
    template:'agile_board'
    onBeforeAction:()->
      if RP_permissions.hasPermissions(['canViewLoadList','canManageLoad'])
        @next()
        null
      else
        @render 'home'
        null
    )


  @route('filteredSchedules',
    path:'/loads/filter/:status'
    template:'scheduleList'
    onBeforeAction:()->
      if RP_permissions.hasPermissions(['canViewLoadList','canManageLoad'])
        @next()
        null
      else
        @render 'home'
        null
    data:->
      filter=getFilter @params.status,@params.hash
      Schedules.find(filter.filter).fetch()
    waitOn:->
      filter=getFilter @params.status,@params.hash
      handle=Meteor.subscribeWithPagination('schedules',filter,true,10)
      @state.set('subsHandle',handle)
      handle
  )

  @route('newSchedule',
    path:'/loads/new'
    onBeforeAction:()->
      if RP_permissions.hasPermissions(['canCreateLoad','canManageLoad'])
        @next()
      else
        @render 'home'
        null
    template:"manageSchedule")

  @route('editSchedule',
    path:'/loads/edit/:_id',
    onBeforeAction:()->
      if RP_permissions.hasPermissions(['canEditLoad','canManageLoad'])
        @next()
        null
      else
        @render 'home'
        null
    data:->Schedules.findOne(@params._id),
    waitOn:->
      Meteor.userId()
      Meteor.subscribe('schedules',{filter:{_id:@params._id}})
    template:"manageSchedule"
  )

  @route('viewSchedule',
    path:'/loads/view/:_id',
    data:->Schedules.findOne(@params._id),
    onBeforeAction:()->
      if RP_permissions.hasPermissions(['canViewLoad','canManageLoad'])
        @next()
        null
      else
        @render 'home'
        null
    waitOn:->
      Meteor.userId()
      Meteor.subscribe('schedules',{filter:{_id:@params._id}})
    template:"scheduleDetail"
  )








