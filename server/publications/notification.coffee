Meteor.publish('notifications',(user)->
  Activities.find({audience:{$in:[user]},isNew:true})
)