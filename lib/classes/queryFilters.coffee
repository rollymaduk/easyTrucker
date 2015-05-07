class @QueryFilterService
  constructor:(@server)->
  scheduleListByRoles:()->
    roles=null
    userId=null
    if @server
      unless not @server.userId
        user=Meteor.users.findOne(@server.userId)
        roles=Roles.getRolesForUser user,user.username
        userId=@server.userId
    else
      unless not Meteor.user()
        rolesObj=Meteor?.user()?.roles
        roles=_.values(rolesObj)[0]
        userId=Meteor.userId()
    unless not roles
      switch
        when _.contains(roles,'trucker') then filter:{truckers:{$in:[userId]}},modifier:sort:{createdAt:-1}
        when _.contains(roles,'shipper') then filter:{owner:userId},modifier:sort:{createdAt:-1}
        else null






