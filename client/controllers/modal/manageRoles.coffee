Template.manageRoles.helpers
  roles:->
    roles=Template.currentData()?.roles
    console.log roles
    if roles
      {roles:_.values(roles)[0]}
  roleSelectize:()->
    options: ()->
      role=Meteor.user().role()
      CommonHelpers.getAllRoles(role)
    valueField:"value"
    labelField:"label"
    plugins: ['remove_button']


Template.manageRoles.events
  'click .save-modal':(evt,temp)->
    values=AutoForm.getFormValues 'manageRoleForm'
    roles= values.insertDoc.roles
    console.log temp.data
    console.log roles
    Meteor.call 'updateRoles',temp.data,roles,(err,res)->
      Modal.hide()
      if err
        swal 'Failure',err.message,'error'
        return
      return







