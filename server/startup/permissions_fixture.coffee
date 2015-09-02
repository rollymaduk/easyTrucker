Meteor.startup ->
  _.each(PermissionsFixture,(item)->
      console.log item.role
      permissions=RP_permissions.getPermissionsForRoles(item.role)
      RP_permissions.createPermissions item.role,_.difference(item.perm,permissions)
    )
