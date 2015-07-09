Meteor.startup ->
  PermissionsFixture=[{
    role:'shipper'
    perm:[
      'canCreateLoad',
      'canViewbid',
      'canViewbidList',
      'canEditLoad',
      'canViewLoad',
      'canViewDashboard',
      'canManageUsers',
      'canViewMatchedLoads',
      'canViewUnmatchedLoads'
    ]
  },{role:'trucker',perm:['canCreateTruck',
                          'canEditTruck',
                          'canViewTruck'
                          'canCreatebid',
                          'canEditbid',
                          'canViewbidList',
                          'canViewbid'
                          'canViewLoad',
                          'canViewDashboard',
                          'canManageUsers',
                          'canViewBiddedLoads',
                          'canViewMatchedLoads'

  ]}]

  _.each(PermissionsFixture,(item)->
      item.role
      permissions=RP_permissions.getPermissionsForRoles(item.role)
      RP_permissions.createPermissions item.role,_.difference(item.perm,permissions)
    )
