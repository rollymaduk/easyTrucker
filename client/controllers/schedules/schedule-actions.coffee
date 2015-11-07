Template.schedule_actions.events
  'click .dispatch-load':(evt,temp)->
    Modal.show 'dispatchModal',{schedule:temp.data.item._id
      ,subject:"#{temp.data.item.wayBill}-#{temp.data.item.shipmentTitle}"}

  'click .deliver-load':(evt,temp)->
    Modal.show 'deliveryModal',{schedule:temp.data.item._id
      ,subject:"#{temp.data.item.wayBill}-#{temp.data.item.shipmentTitle}"}

  'click .assign-resource':(evt,temp)->
    ###unless AppPlans.get() then AppPlans.set(SUBSCRIBE_FREE,{userId: Meteor.userId()},(err)->console.log err)###

    Eztrucker.Utils.Payment.checkUserPlan temp.data.item._id,->
      Router.go "filteredTruckList",{trucks:temp.data.item.matchedTrucks()},{hash:temp.data.item._id}



