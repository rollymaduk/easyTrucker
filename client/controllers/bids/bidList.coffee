
Template.bidListItem.helpers
  activity:->
    Activities.findOne({documentId:@_id},{sort:{createdAt:-1}})

  message:->
    Messages.findOne({documentId:@_id},{sort:{createdAt:-1}})

Template.bidList.helpers
  canInsert:()->
    RP_permissions.hasPermissions(['canCreatebid','canEditbid','canManagebid'])

  hasBid:->
    ###todo filter by schedule id during optimization###
    Bids.findOne({owner:Meteor.userId()})

  schedule:->
    Iron.controller().getParams()._id








