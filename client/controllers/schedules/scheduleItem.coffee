Template.scheduleItem.events
  'click .duplicate-load':(evt,temp)->
    Modal.show 'duplicateScheduleModal',temp.data

  'click #toggleSchedule':(evt,temp)->
    id=".#{temp.data._id}"
    $(id).toggle('slow');









