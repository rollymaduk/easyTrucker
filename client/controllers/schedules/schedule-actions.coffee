

Template.schedule_actions.events
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
    ###unless AppPlans.get() then AppPlans.set(SUBSCRIBE_FREE,{userId: Meteor.userId()},(err)->console.log err)###

    Eztrucker.Utils.Payment.checkUserPlan temp.data.item._id,->
      Router.go "filteredTruckList",{trucks:temp.data.item.matchedTrucks()},{hash:temp.data.item._id}



