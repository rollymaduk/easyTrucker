Eztrucker.Utils.Schedules=
{
  getFilterQueryByRoles:(roles,userId,isLight,limit=10)->
    unless not roles
      res={}
      switch
        when _.contains(roles,ROLE_TRUCKER) then res=filter:{'truckers.owner':{$in:[userId]}}
        when _.contains(roles,ROLE_SHIPPER) then res=filter:{owner:userId}
        when _.contains(roles,ROLE_DRIVER) then res=filter:{'resource.driver':userId
          ,status:{$nin:[STATE_BOOKED,STATE_NEW]}}
        else throw new Meteor.Error(3001,'Role does not exist')
      if isLight
        fieldsLight=CommonHelpers.getScheduleFieldsLight()
        _.extend res,modifier:{sort:{createdAt:-1},limit:limit,fieldsLight}
      else
        _.extend res,modifier:{sort:{createdAt:-1},limit:limit}
    else throw new Meteor.Error(3002,"Invalid Roles object")
}