###hacky method to get filters for load requests based on the url hash value as field name or using d
  default status from helper library###
getFilter=(value,field)->
  unless field
    CommonHelpers.getFiltersForSchedule(value)
  else
    CommonHelpers.buildFilterQry([{field:field,value:value?.split(',') or [],operator:'$in'}])

Router.map ()->
  @route('scheduleList',
    path:'app/loads'
    template:'agile_board'
    data:->
      service=new QueryFilterService(null)
      query=service.scheduleListByRoles()
      console.log query
      if(query)
        newJobFilters={status:STATE_NEW}
        inProgFilters={status:$in:[STATE_BOOKED,STATE_ASSIGNED,STATE_DISPATCH,STATE_LATE]}
        compFilters={status:$in:[STATE_CANCELLED,STATE_ISSUE,STATE_SUCCESS]}
        {
          newJobs:Schedules.find(_.extend(query.filter,newJobFilters),query.modifier).fetch(),
          inProgressJobs:Schedules.find(_.extend(query.filter,inProgFilters),query.modifier).fetch(),
          completeJobs:Schedules.find(_.extend(query.filter,compFilters),query.modifier).fetch(),
        }
    waitOn:->
      Meteor.subscribe('scheduleList'))


  @route('filteredSchedules',
    path:'app/loads/filter/:status'
    template:'scheduleList'
    data:->
      service=new QueryFilterService(null)
      query=service.scheduleListByRoles()
      if(query)
        filter=getFilter @params.status,@params.hash
        _.extend query.filter,filter.filter
        Schedules.find(query.filter,query.modifier).fetch()
    waitOn:->
      filter=getFilter @params.status,@params.hash
      Meteor.subscribe('scheduleList',filter)

  )

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
      dispatch=Dispatches.findOne() or {schedule:@params._id}
      _.extend(dispatch,{shipmentTitle:@params.shipmentTitle})
    waitOn:->
      Meteor.subscribe('dispatches',@params._id)
      Meteor.subscribe('eZFiles')
  )

  @route('newSchedule',
    path:'/app/loads/new'
    onBeforeAction:()->
      if RP_permissions.hasPermissions(['canCreateLoad','canManageLoad'])
        @next()
      else
        @render 'home'
        null
    waitOn:->
      Meteor.subscribe('eZFiles')
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
    waitOn:->
      Meteor.subscribe('scheduleDetailItem',@params._id)
    template:"manageSchedule")

  @route('viewSchedule',
    path:'/app/loads/view/:_id',
    data:->Schedules.findOne(@params._id),
    waitOn:->Meteor.subscribe('scheduleDetailItem',@params._id)
    template:"scheduleDetail")








