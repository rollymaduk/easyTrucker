Template.scheduleItem.events
  'click #toggleSchedule':(evt,temp)->
    id=".#{temp.data._id}"
    $(id).toggle('slow');









