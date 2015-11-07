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
    data:->
      newJobFilters={status:$in:[STATE_NEW,STATE_BOOKED]}
      inProgressFilters={status:$in:[STATE_ASSIGNED,STATE_DISPATCH,STATE_LATE]}
      completeFilters={status:$in:[STATE_ISSUE,STATE_SUCCESS]}
      if Meteor.user().role() is ROLE_DRIVER
        newJobFilters.status.$in.push(STATE_ASSIGNED)
        inProgressFilters.status.$in=_.without(inProgressFilters.status.$in,STATE_ASSIGNED)
      {
        newJobs:Schedules.find(newJobFilters).fetch(),
        inProgressJobs:Schedules.find(inProgressFilters).fetch(),
        completeJobs:Schedules.find(completeFilters).fetch()
      }
    waitOn:->
      Meteor.subscribe('schedules',{},true))


  @route('filteredSchedules',
    path:'/loads/filter/:status'
    template:'scheduleList'
    data:->
      filter=getFilter @params.status,@params.hash
      Schedules.find(filter.filter).fetch()
    waitOn:->
      filter=getFilter @params.status,@params.hash
      Meteor.subscribe('schedules',filter,true)

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
      Meteor.subscribe('schedules',{filter:{_id:@params._id}})
    template:"manageSchedule")

  @route('viewSchedule',
    path:'/loads/view/:_id',
    data:->Schedules.findOne(@params._id),
    waitOn:->Meteor.subscribe('schedules',{filter:{_id:@params._id}})
    template:"scheduleDetail")








