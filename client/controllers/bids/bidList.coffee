Template.bidListItem.helpers
  bidder:()->
    Meteor.users.findOne(@owner).profile.name
  notification:()->
    Activities.findOne({isNew:true,'route.param._id':@_id})