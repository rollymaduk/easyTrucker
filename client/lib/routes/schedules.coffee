Router.map ()->
  @route('scheduleList',
    path:'app/user/schedules'
    data:->
      service=new QueryFilterService(null)
      query=service.scheduleListByRoles()
      if(query)
        Schedules.find(query.filter,query.modifier)
    waitOn:->Meteor.subscribe('scheduleList'))

  @route('newSchedule',
    path:'/app/schedules/new'
    template:"manageSchedule")

  @route('editSchedule',
    path:'/schedules/edit/:_id',
    data:->Schedules.findOne(@params._id),
    waitOn:->Meteor.subscribe('scheduleItem',@params._id)
    template:"manageSchedule")

  @route('viewSchedule',
    path:'/app/schedules/view/:_id',
    onBeforeAction:()->
      roles=Meteor?.user().roles
      if roles and _.contains(_.values(roles)[0],'shipper')
        @redirect 'bidList',{_id:@params._id} if not @params.acceptedBid
        null
      else
        @next()
        null
    data:->Schedules.findOne(@params._id),
    waitOn:->Meteor.subscribe('scheduleItem',@params._id)
    template:"scheduleDetail")








