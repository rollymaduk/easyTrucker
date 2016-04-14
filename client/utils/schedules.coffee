getIdentity=(user)->
  user.company() or user.fullname()

Eztrucker.Utils.Schedules=_.extend(Eztrucker.Utils.Schedules,{
  acceptBidAction:(data)->
    swal
      title:'Accepting Bid!'
      text:"Send acceptance note to #{getIdentity(data.bidder())}"
      showCancelButton: true,
      closeOnConfirm:false
    ,(isConfirmed)->
      if isConfirmed
        winningBid={bidder:data.owner,bid:data._id}
        console.log data.schedule
        Meteor.call 'acceptScheduleBid',data.schedule._id,winningBid,(err,res)->
          if res
            swal("Success", "Your bid acceptance was successful",'success');
            Router.go 'filteredSchedules',{status:STATE_BOOKED}
          else
            console.log err
      else false
})