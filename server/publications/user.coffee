Meteor.publish('userList',(domainroles)->
  roles=domainroles?.roles
  group=domainroles?.group
  if roles and group
    Roles.getUsersInRole(roles,group)
  else
    @ready()
)