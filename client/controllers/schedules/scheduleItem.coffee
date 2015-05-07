Template.scheduleItem.helpers
  bidCount:()->
    Bids.find({schedule:@_id}).count()

  hasBid:()->
    if(Meteor.userId())
      Bids.find({schedule:@_id,owner:Meteor.userId()}).count()

  canBid:()->
    roles=Meteor?.user()?.roles
    console.log roles
    _.contains(_.values(roles)[0],'trucker') if roles

Template.scheduleItem.events
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
            Schedules.remove(data._id,(err,success)->
              switch
                when success then swal("Deleted","successfully removed schedule!",'success')
                else
                  swal("Failure","An Error occurred during delete !",'error')
            )






