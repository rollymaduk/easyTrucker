Template.dispatchModal.events
  'click .save-modal':(evt,temp)->
    console.log "submit form"
    $('#manageDispatchForm').submit()
