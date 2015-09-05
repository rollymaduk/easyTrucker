Bids.join(Schedules,'schedule','scheduleItem',['status','shipmentTitle','owner','pickupDate','dropOffDate','maximumBidPrice'])
Bids.join(Meteor.users,'owner','bidder',['profile'])
