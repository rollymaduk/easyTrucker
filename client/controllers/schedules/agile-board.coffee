Template.agile_board.helpers
  canInsert:()->
    RP_permissions.hasPermissions(['canCreateLoad','canManageLoad'])
    
Template.jobItem.events
  'click .work-item':(evt,temp)->
    console.log temp.data
    unless $(evt.target).is('a')
      Router.go('viewSchedule',{_id:temp.data._id})
