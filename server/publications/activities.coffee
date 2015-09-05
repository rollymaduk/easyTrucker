Meteor.publish('activities',(qry)->
  if @userId
    qry=qry or {}
    Activities.find(qry)
  else
    @ready()
)