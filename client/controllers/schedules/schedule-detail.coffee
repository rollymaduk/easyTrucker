Template.scheduleDetail.created=()->
  @showManageBid=new ReactiveVar(false)


Template.scheduleDetail.helpers
  showManageBid:()->
    Template.instance().showManageBid.get()

  canEditBid:()->
   if RP_permissions.hasPermissions(['canEditbid','canManagebid']) then 'place-bid' else null


Template.scheduleDetail.events
  'click .place-bid':(evt,temp)->
    temp.showManageBid.set(true)

  'click .cancel-bid':(evt,temp)->
    temp.showManageBid.set(false)

Template.scheduleDetail.rendered=()->
  AutoForm.hooks
    scheduleCommentsForm:
      onSubmit:(ins,upd,curr)->
        Meteor.call 'addScheduleComment',@docId,ins,(err,res)=>
          console.log err or res
          @done()
        false


AutoForm.debug()

