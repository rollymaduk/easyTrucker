Template.schedule_actions.events
  'click .assign-truck':(evt,temp)->
    data=temp.data.item
    Session.set('acceptedRequestItem',{schedule:data._id
      ,title:"#{data.shipmentTitle} - #{data.wayBill}"
      ,pickupDate:data.bid().proposedPickup
      ,dropOffDate:data.bid().proposedDelivery})
    null
