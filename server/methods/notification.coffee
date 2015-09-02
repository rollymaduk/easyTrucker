Meteor.methods
  createNotification:(notifyObj)->
    Notifications.insert notifyObj