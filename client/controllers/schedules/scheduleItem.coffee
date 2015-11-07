Template.scheduleItem.events
  'click .duplicate-load':(evt,temp)->
    Modal.show 'duplicateScheduleModal',temp.data

  'click #toggleSchedule':(evt,temp)->
    id=".#{temp.data._id}"
    $(id).toggle('slow');

  'click .remove-schedule':(evt,temp)->
    data=@
    swal
      type:'warning'
      text:'This schedule and all associated data will be removed'
      title:"Are you sure?"
      showCancelButton:true
      closeOnConfirm:false
      ,(isConfirm)->
        switch isConfirm
          when on
            Meteor.call 'removeSchedule',data._id,(err,success)->
              switch
                when success then swal("Deleted","successfully removed schedule!",'success')
                else
                  swal("Failure","An Error occurred during delete !",'error')







