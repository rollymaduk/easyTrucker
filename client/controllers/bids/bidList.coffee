getIdentity=(user)->
  user.company() or user.fullname()

Template.bidListItem.events
  'click .accept-bid':(evt,temp)->
    swal
      title:'Accepting Bid!'
      text:"Send acceptance note to #{getIdentity(temp.data.bidder)}"
      showCancelButton: true,
      closeOnConfirm:false
    ,(isConfirmed)->
        if isConfirmed
          winningBid={bidder:temp.data.owner,bid:temp.data._id}
          console.log temp.data.schedule
          Meteor.call 'acceptScheduleBid',temp.data.schedule,winningBid,(err,res)->
            if res
              swal("Success", "Your bid acceptance was successful",'success');
              Router.go 'filteredSchedules',{status:STATE_BOOKED}
            else
              console.log err
        else false

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








