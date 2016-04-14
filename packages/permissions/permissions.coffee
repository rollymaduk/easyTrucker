@R_polly_permissions=new Meteor.Collection('r_polly_permissions')


if Meteor.isServer
  Meteor.publish 'r_polly_perm_publish',()->
    if @userId
      group=Roles.getGroupsForUser(@userId)[0]
      userRoles=Roles.getRolesForUser(@userId,group)
      filter=roles:$in:userRoles
      R_polly_permissions.find(filter)

