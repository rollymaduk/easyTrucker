@PermissionsFixture=[{
  role:ROLE_SHIPPER
  perm:[
    'canCreateLoad',
    'canViewbid',
    'canViewbidList',
    'canAcceptBid',
    'canEditLoad',
    'canViewLoad',
    'canViewDashboard',
    'canManageUsers',
    'canViewMatchedLoads',
    'canViewUnmatchedLoads',
    'canViewAcceptedLoads'
  ]
},{role:ROLE_TRUCKER,perm:['canCreateTruck',
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
                        'canViewMatchedLoads',
                        'canAssignTruck',
                        'canViewAcceptedLoads',
                        'canDispatchLoad',
                        'canCloseRequest'
]},
  {
    role:ROLE_DRIVER
    perm:[
      'canViewTruck',
      'canViewbidList',
      'canViewDashboard',
      'canDispatchLoad',
      'canCloseRequest'
    ]
  }
]