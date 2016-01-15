AutoForm.hooks
  duplicateForm:
    onSubmit:(ins,upd,curr)->
      doc=ins
      that=@
      Meteor.call 'duplicateSchedule',doc._id,doc,(err,res)->
        that.done()
        if res then Modal.hide() else console.log err
      false
    beginSubmit: ()->
      $('.save-modal').toggleClass("disabled")
    endSubmit:()->
      $('.save-modal').toggleClass("disabled")