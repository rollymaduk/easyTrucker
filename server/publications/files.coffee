Meteor.publish 'files',(qry)->
  if @userId
    qry=qry or {}
    eZFiles.find(_.extend(qry,{owner:@userId}))
  else
    @ready()
