Meteor.publishComposite 'schedules',(qry,isLight=false,limit=10)->
  unless @userId
    return
  user=Meteor.users.findOne(@userId)
  find:()->
    {filter,modifier}=Eztrucker.Utils.Schedules.getFilterQueryByRoles(user,isLight)
    filter=_.extend(filter,qry.filter)
    modifier=_.extend(modifier,{limit:limit})
    cursor=Schedules.find(filter,modifier)
    Counts.publish(@,"total-requests",Schedules.find(filter))
    cursor
  children:[
    find:(schedule)->
      qry={parent:schedule._id,audience:$in:[user._id]}
      ###latest schedule activity###
      Rp_Notification.getActivities(qry,{limit:1,sort:createdAt:-1})

    find:(schedule)->
      ###rating entry###
      Rp_Rating.getRatings({docId:schedule._id,$or:[{createdBy:user._id},audience:{$in:[user._id]}]})
  ]






