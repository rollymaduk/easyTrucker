Template.agile_board.helpers
  canInsert:()->
    RP_permissions.hasPermissions(['canCreateLoad','canManageLoad'])

  newJobs:()->
    Schedules.find(Template.instance().newJobFilters).fetch()

  inProgressJobs:()->
     Schedules.find(Template.instance().inProgressFilters).fetch()

  completeJobs:()->
    Schedules.find(Template.instance().completeFilters).fetch()


    
Template.jobItem.events
  'click .work-item':(evt,temp)->
      console.log temp.data
      unless $(evt.target).is('a')
        Router.go('viewSchedule',{_id:temp.data._id})


Template.agile_board.created=->
  @newJobFilters=if Session.get('currentRole') is ROLE_DRIVER then {status:$in:[STATE_ASSIGNED]} else {status:$in:[STATE_NEW]}
  @inProgressFilters=if Session.get('currentRole') is ROLE_DRIVER then {status:$in:[STATE_DISPATCH,STATE_LATE]} else {status:$in:[STATE_ASSIGNED,STATE_DISPATCH,STATE_LATE,STATE_BOOKED]}
  @completeFilters={status:$in:[STATE_ISSUE,STATE_SUCCESS]}
  @autorun =>
    Meteor.userId()

    @subscribe('schedules',{filter:@newJobFilters},true,5)
    @subscribe('schedules',{filter:_.extend(CommonHelpers.getFiltersForSchedule(null).filter,@inProgressFilters)},true,5)
    @subscribe('schedules',{filter:_.extend(CommonHelpers.getFiltersForSchedule(null).filter,@completeFilters)},true,5)


