Meteor.publish('userList',(domainroles)->
  ###todo fix security hole here remove domainroles parameter###
  roles=domainroles?.roles
  group=domainroles?.group
  if roles and group
    Roles.getUsersInRole(roles,group)
  else
    @ready()
)

Meteor.publish 'userInfo',(id,withImage)->
  Meteor.users.find(id,fields:profile:1)

