Meteor.methods
  manageMessage:(message,docId)->
    unless docId
      Messages.insert message
    else
      Messages.update message