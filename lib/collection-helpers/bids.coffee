Bids.helpers
  bidder:->
    console.log @owner
    Meteor.users.findOne(@owner)

  notification:->
    Activities.findOne({isNew:true})