Meteor.publish('userList',(domainroles)->
  roles=domainroles?.roles
  group=domainroles?.group
  if roles and group
    Roles.getUsersInRole(roles,group)
  else
    @ready()
)

Meteor.publish('userInfo',(id)->
  if @userId
    check(id,String)
    console.log id
    Meteor.users.find(id,fields:profile:1)
  else
    @ready()
)
