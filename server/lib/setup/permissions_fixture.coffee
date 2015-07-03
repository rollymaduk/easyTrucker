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
      'canViewMatchedLoads'
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
                          'canViewBiddedLoads'

  ]}]

  roles=_.map(PermissionsFixture,(item)->
    item.role
  )
  permissions=RP_permissions.getPermissionsForRoles(roles)
  RP_permissions.createPermissions item.role,_.difference(item.perm,permissions) for item in PermissionsFixture