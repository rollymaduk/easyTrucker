Template.scheduleItem.events
  'click .assign-truck':(evt,temp)->
    Session.set('acceptedRequestItem',{schedule:temp.data._id
      ,title:"#{temp.data.shipmentTitle} - #{temp.data.wayBill}"
      ,pickupDate:temp.data.bid().proposedPickup
      ,dropOffDate:temp.data.bid().proposedDelivery})
    null

  'click .duplicate-load':(evt,temp)->
    temp.data._id=undefined
    temp.data.bidders=[]
    temp.data.messages=[]
    temp.data.totalBids=0
    temp.data.truck=undefined
    temp.data.driver=undefined
    temp.data.status=STATE_NEW

    Meteor.call('addUpdateSchedule',_.omit(temp.data,['updatedAt','createdAt','updatedBy','createdBy']),(err,res)->)

  'click #toggleSchedule':(evt,temp)->
    id=".#{temp.data._id}"
    $(id).toggle('slow');
  'click .remove-schedule':(evt,temp)->
    data=@
    swal
      type:'warning'
      text:'This schedule and all associated data will be removed'
      title:"Are you sure?"
      showCancelButton:true
      closeOnConfirm:false
      ,(isConfirm)->
        switch isConfirm
          when on
            Schedules.remove(data._id,(err,success)->
              switch
                when success then swal("Deleted","successfully removed schedule!",'success')
                else
                  swal("Failure","An Error occurred during delete !",'error')
            )






