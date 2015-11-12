Template.scheduleDetail.created=()->
  Rp_Notification.setActivityFilter(parent:@data._id)
  @autorun ->
    Rp_Notification.initActivities(10)


Template.scheduleDetail.rendered=()->
  Rp_Comment.setFilter({parent:@data._id})




