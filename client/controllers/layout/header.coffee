Template.header.events
  'click .logout':(evt,temp)->
    Meteor.logout((err)->
      if err
        swal 'Logout Failure',err.message,'error'
    )


Template.header.helpers
  alerts:()->
    Notifications.find({collectionName:COLLECTION_ACTIVITY}).fetch()

  messages:()->
    Notifications.find({collectionName:COLLECTION_MESSAGE}).fetch()

Template.alertItem.helpers
  isBidAlert:()->
    @notification.collectionName is COLLECTION_BID
