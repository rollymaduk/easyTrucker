Template.header.events
  'click .logout':(evt,temp)->
    Meteor.logout((err)->
      if err
        swal 'Logout Failure',err.message,'error'
    )


Template.header.helpers
  alerts:()->
    Rp_Notification.getAlerts({collection:$in:[COLLECTION_REQUEST,COLLECTION_BID]})

  messages:()->
    Rp_Notification.getAlerts({collection:COLLECTION_COMMENT})

###

Template.alertItem.helpers
  isBidAlert:()->
    false

Template.messageNotifyItem.helpers
  isBidAlert:()->
    false###
