###
FastRender.onAllRoutes((path)->
  @subscribe('notifications',Meteor.userId()) if Meteor.userId())###
