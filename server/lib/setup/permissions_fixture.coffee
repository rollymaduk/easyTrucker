Meteor.startup ->
  PermissionsFixture=[{
    role:'shipper'
    perm:[
      'canCreateLoad',
      'canViewbid',
      'canViewbidList',
      'canEditLoad',
      'canViewLoad',
      'canViewDashboard'
    ]
  },{role:'trucker',perm:['canCreateTruck',
                          'canEditTruck',
                          'canViewTruck'
                          'canCreatebid',
                          'canEditbid',
                          'canViewbid'
                          'canViewLoad',
                          'canViewDashboard']}]

  roles=_.map(PermissionsFixture,(item)->
    item.role
  )
  permissions=RP_permissions.getPermissionsForRoles(roles)
  if(permissions.length<1)
    RP_permissions.createPermissions item.role,item.perm for item in PermissionsFixture