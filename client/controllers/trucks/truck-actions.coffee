Template.truckActions.events
  'click .view-schedule':(evt,temp)->
    Modal.show 'calendarModal',temp.data.schedule()

  'click .assign-driver':(evt,temp)->
    item= {truck:temp.data._id,drivers:temp.data.drivers()}
    Modal.show 'chooseDriverModal',{data:item}

  'click .duplicate-truck':(evt,temp)->
    Meteor.call 'addUpdateTruck',temp.data._id,(err,res)->
      console.log err or res

  'click .remove-truck':(evt,temp)->
    data=@
    swal
      type:'warning'
      text:'This truck will be removed'
      title:"Are you sure?"
      showCancelButton:true
      closeOnConfirm:false
    ,(isConfirm)->
      switch isConfirm
        when on
          Meteor.call 'removeTruck',data._id,(err,success)->
            switch
              when success then swal("Removed","successfully removed truck!",'success')
              else
                swal("Failure","An Error occurred during delete !",'error')
