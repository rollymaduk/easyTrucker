Meteor.publish 'eZImages',(qry)->
  if userId()
    qry=qry or {}
    qry=_.extend(qry,{owner:userId})
    eZImages.find(qry)
  @ready()