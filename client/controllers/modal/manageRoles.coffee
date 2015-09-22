Template.manageRoles.helpers
  roles:->
    roles=Template.currentData()?.roles
    console.log roles
    if roles
      {roles:_.values(roles)[0]}
  roleSelectize:()->
    options: ()->
      CommonHelpers.getAllRoles(ROLE_TRUCKER)
    valueField:"val"
    labelField:"lbl"
    plugins: ['remove_button']


Template.manageRoles.events
  'click .save-modal':(evt,temp)->
    values=AutoForm.getFormValues 'manageRoleForm'
    roles= values.insertDoc.roles
    console.log roles
    Meteor.call 'updateRoles',temp.data,roles,(err,res)->
      if res
        Modal.hide()
        null
      else
        swal 'Failure',err.message,'error'
        null







