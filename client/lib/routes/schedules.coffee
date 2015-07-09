Router.map ()->
  @route('scheduleList',
    path:'app/loads'
    data:->
      service=new QueryFilterService(null)
      query=service.scheduleListByRoles()
      if(query)
        Schedules.find(query.filter,query.modifier)
    waitOn:->
      Meteor.subscribe('scheduleList'))


  @route('filteredSchedules',
    path:'app/loads/filter/:status'
    template:'scheduleList'
    data:->
      service=new QueryFilterService(null)
      query=service.scheduleListByRoles()
      if(query)
        filter=CommonHelpers.getFiltersForSchedule(@params.status)
        _.extend query.filter,filter.filter
        Schedules.find(query.filter,query.modifier)
    waitOn:->
      filter=CommonHelpers.getFiltersForSchedule(@params.status)
      Meteor.subscribe('scheduleList',filter)

  )



  @route('newSchedule',
    path:'/app/loads/new'
    onBeforeAction:()->
      if RP_permissions.hasPermissions(['canCreateLoad','canManageLoad'])
        @next()
      else
        @render 'home'
        null
    template:"manageSchedule")

  @route('editSchedule',
    path:'app/loads/edit/:_id',
    onBeforeAction:()->
      if RP_permissions.hasPermissions(['canEditLoad','canManageLoad'])
        @next()
        null
      else
        @render 'home'
        null
    data:->Schedules.findOne(@params._id),
    waitOn:->Meteor.subscribe('scheduleItem',@params._id)
    template:"manageSchedule")

  @route('viewSchedule',
    path:'/app/loads/view/:_id',
    data:->Schedules.findOne(@params._id),
    waitOn:->Meteor.subscribe('scheduleItem',@params._id)
    template:"scheduleDetail")








