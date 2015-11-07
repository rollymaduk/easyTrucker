Bids.helpers
  bidder:->
    Meteor.users.findOne(@owner)

  latestActivity:->
    Rp_Notifications.findOne({docId:@_id},{sort:{createdAt:-1}})





