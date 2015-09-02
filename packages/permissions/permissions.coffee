@R_polly_permissions=new Meteor.Collection('r_polly_permissions')


if Meteor.isServer
  Meteor.publish 'r_polly_perm_publish',(roles)->
    if @userId
      user=Meteor.users.findOne(@userId)
      group=_.keys(user.roles)[0]
      userRoles=Roles.getRolesForUser(user,group)
      roles= unless _.isArray(roles) then [roles] else roles
      filter=roles:$in:_.intersection(userRoles,roles)
      R_polly_permissions.find(filter)

