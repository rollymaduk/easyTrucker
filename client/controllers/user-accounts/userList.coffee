Template.userItem.events
  'click .toggleUserState':(evt,temp)->
    Meteor.call 'toggleUserState',temp.data,(err,res)->
      console.log err||res

  'click .manageRoles':(evt,temp)->
    Modal.show 'manageRoles',temp.data


Template.userItem.helpers
  canToggleUser:->
    logged=Meteor?.userId()
    if logged
      Template.currentData()._id != logged

