class @QueryFilterService
  constructor:(@server)->
  scheduleListByRoles:()->
    roles=null
    userId=null
    if @server
      unless not @server.userId
        user=Meteor.users.findOne(@server.userId)
        group=_.keys(user.roles)[0]
        roles=Roles.getRolesForUser user,group
        userId=@server.userId
    else
      unless not Meteor.user()
        rolesObj=Meteor?.user()?.roles
        roles=_.values(rolesObj)[0]
        userId=Meteor.userId()
    unless not roles
      switch
        when _.contains(roles,ROLE_TRUCKER) then filter:{'truckers.owner':{$in:[userId]}},modifier:sort:{createdAt:-1}
        when _.contains(roles,ROLE_SHIPPER) then filter:{owner:userId},modifier:sort:{createdAt:-1}
        when _.contains(roles,ROLE_DRIVER) then filter:{'resource.driver':userId},modifier:sort:{createdAt:-1}
        else null






