Meteor.publishRelations 'schedules',(qry,isLight,limit)->
  user=Meteor.users.findOne(@userId)
  group=_.keys(user.roles)[0]
  roles=Roles.getRolesForUser user,group
  query=Eztrucker.Utils.Schedules.getFilterQueryByRoles(roles,@userId,isLight,limit)
  filter=qry?.filter
  modifier=qry?.modifier
  _.extend query.filter,filter if filter
  _.extend query.modifier,modifier if modifier
  @cursor Schedules.find(query.filter,query.modifier),(docId,doc)=>
    @cursor Rp_Notification.getActivities({docId:docId,audience:$in:[@userId]},{limit:1,sort:createdAt:-1})
    @cursor Rp_Ratings.find({$and:[{docId:docId},{$or:[audience:{$in:[@userId]},{createdBy:@userId}]}]})
    null
  @ready()


