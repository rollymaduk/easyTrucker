Meteor.publishRelations 'schedules',(qry,isLight=false,limit=10)->
  if @userId
    user=Meteor.users.findOne(@userId)
    {filter,modifier}=Eztrucker.Utils.Schedules.getFilterQueryByRoles(user,isLight)
    filter=_.extend(filter,qry.filter)
    modifier=_.extend(modifier,{limit:limit})
    @cursor Schedules.find(filter,modifier),(docId,doc)->
      qry={parent:docId,audience:$in:[user._id]}
      @cursor Rp_Notification.getActivities(qry,{limit:1,sort:createdAt:-1})
      ###@cursor Rp_Ratings.find({$and:[{docId:docId},{$or:[audience:{$in:[@userId]},{createdBy:@userId}]}]})###
      return
  @ready()


