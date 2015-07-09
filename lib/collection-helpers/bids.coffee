Bids.helpers
  comments:->
    _.each(@messages,(doc)->
      doc.owner=Meteor.users.findOne(doc.owner))
    @messages

  shipmentTitle:->
    Schedules.findOne(@schedule).shipmentTitle

  bidder:->
    Meteor.users.findOne(@owner)

  notification:->
    Activities.findOne({isNew:true})

