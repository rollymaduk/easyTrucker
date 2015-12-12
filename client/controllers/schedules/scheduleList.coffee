Template.scheduleList.helpers
  canInsert:()->
    RP_permissions.hasPermissions(['canCreateLoad','canManageLoad'])

  canLoadMore:()->
    Counts.get('total-requests')>Schedules.find().count()


Template.scheduleList.created=->
  params=Iron.controller().params
  filter=CommonHelpers.getFilterForScheduleExtended params.status,params.hash
  @handle=Meteor.paginatedSubscribe('schedules',filter,{perPage:10},()->
    console.log("subs ready!")
  )

Template.scheduleList.events
  'click .load-more':(evt,temp)->
    console.log "hello"
    temp.handle.loadNextPage()

