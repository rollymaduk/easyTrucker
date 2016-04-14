

Template.schedule_actions.events
  'click .duplicate-load':(evt,temp)->
    Modal.show 'duplicateScheduleModal',temp.data.item

  'click .dispatch-load':(evt,temp)->
    Modal.show 'dispatchModal',{schedule:temp.data.item._id
      ,subject:"#{temp.data.item.wayBill}-#{temp.data.item.shipmentTitle}"}

  'click .deliver-load':(evt,temp)->
    Modal.show 'deliveryModal',{schedule:temp.data.item._id
      ,subject:"#{temp.data.item.wayBill}-#{temp.data.item.shipmentTitle}"}

  'click .cancel-schedule':(evt,temp)->
    data=@
    swal
      type:'warning'
      text:'This schedule will be cancelled'
      title:"Are you sure?"
      showCancelButton:true
      closeOnConfirm:false
    ,(isConfirm)->
      switch isConfirm
        when on
          Meteor.call 'cancelSchedule',data.item._id,(err,success)->
            switch
              when success then swal("Cancelled","successfully cancelled schedule!",'success')
              else
                swal("Failure","An Error occurred during delete !",'error')

  'click .assign-resource':(evt,temp)->
    Eztrucker.Utils.Payment.checkUserPlan (err,res)->
     _trucks= temp?.data?.item?.matchedTrucks()
     _id=temp?.data?.item?._id
     if res
       Meteor.setTimeout(()->
         Router.go("filteredTruckList",{trucks:_trucks},{hash:_id})
         return
       ,10)
     return
    return



