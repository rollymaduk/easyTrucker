Bids.helpers
  bidder:->
    Meteor.users.findOne(@owner)

  latestActivity:->
    Rp_Notification.getAllNotifications({docId:@_id},{sort:createdAt:-1},1)[0]

  scheduleIsNew:->
    Schedules.findOne()?.status is STATE_NEW

  isWinningBid:->
    Schedules.findOne()?.winningBid?.bid is @_id










