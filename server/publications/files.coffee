Meteor.publish 'eZFiles',()->
  if userId
    eZFiles.find({owner:userId})
  @ready()
