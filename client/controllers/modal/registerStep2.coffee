Template.registerStep2Modal.events
  'click .save-modal':(evt,temp)->
    $('#registerStep2').submit()

Template.registerStep2Modal.destroyed=->
  $('#myModal').off('hide.bs.modal')

Template.registerStep2Modal.rendered=->
  console.log "modal created"
  $('#myModal').on('hide.bs.modal',(e)->
    console.log 'closing register modal'
    unless(Session.get('registerComplete'))
      e.preventDefault()
  );