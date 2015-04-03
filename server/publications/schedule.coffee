Meteor.publish 'scheduleList',(user,limit)->
  limit=limit||50
  Schedules.find {},{limit:limit}

Meteor.publish 'scheduleItem' ,(id)->
  Schedules.find(id)