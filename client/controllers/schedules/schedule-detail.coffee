Template.scheduleDetail.created=()->
  Rp_Notification.initActivities(20)
  Rp_Notification.setActivityFilter(docId:@data._id)

Template.scheduleDetail.rendered=()->
  Rp_Comment.setFilter({parent:@data._id})




