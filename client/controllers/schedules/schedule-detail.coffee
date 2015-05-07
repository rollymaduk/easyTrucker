Template.scheduleDetail.created=()->
  @showManageBid=new ReactiveVar(false)

Template.scheduleDetail.helpers
  showManageBid:()->
    Template.instance().showManageBid.get()
  bid:()->
    Bids.findOne({schedule:this._id,owner:Meteor.userId()})

Template.scheduleDetail.events
  'click .place-bid':(evt,temp)->
    temp.showManageBid.set(true)

Template.scheduleDetail.events
  'click .cancel-bid':(evt,temp)->
    temp.showManageBid.set(false)

Template.scheduleDetail.rendered=()->
  that=@
  AutoForm.hooks
    placeBidForm:
      onSubmit:(insDoc,updDoc,currDoc)->
        unless insDoc.schedule then insDoc.schedule=that.data._id
        insDoc._id=@docId
        ###console.log insDoc###
        Meteor.call 'placeBid',insDoc,(err,res)=>
          that.showManageBid.set(false)
          console.log err if err
          @done()
          null
        false
  ,true
  null

AutoForm.debug()

