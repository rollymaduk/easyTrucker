Template.duplicateScheduleModal.events
  'click .save-modal':(evt,temp)->
    doc=AutoForm.getFormValues('duplicateForm').insertDoc
    console.log doc
    Meteor.call 'duplicateSchedule',doc._id,doc,(err,res)->
      if res then Modal.hide() else console.log err