Bids.join(Schedules,'schedule','scheduleItem',['status','shipmentTitle','owner','pickupDate','dropOffDate'])
Bids.join(Meteor.users,'owner','bidder',['profile'])
