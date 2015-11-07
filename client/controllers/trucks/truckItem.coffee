Template.truckItem.events
  'click .view-schedule':(evt,temp)->
    Modal.show 'calendarModal',temp.data.schedule()

  'click .assign-driver':(evt,temp)->
    item= {truck:temp.data._id,drivers:temp.data.drivers()}
    Modal.show 'chooseDriverModal',{data:item}

  'click #toggleSchedule':(evt,temp)->
    id=".#{temp.data._id}"
    $(id).toggle('slow');

  'click .duplicate-truck':(evt,temp)->
    temp.data._id=undefined
    Meteor.call 'addUpdateTruck',temp.data,(err,res)->
      console.log err or res


checkForPolicyValidity=(policyDate)->
  new Date()>policyDate


Template.truckItem.destroyed=->
  Meteor.clearInterval(@handle)

Template.truckItem.created=->
  @expiredPolicy=new ReactiveVar(checkForPolicyValidity(@data.expirationDate))

Template.truckItem.rendered=->
  @handle=Meteor.setInterval(
    =>
      @expiredPolicy.set(checkForPolicyValidity(@data.expirationDate))
      console.log @expiredPolicy.get()
      null
  ,50000
  )
  null

Template.truckItem.helpers
  policyIsExpired:->Template.instance().expiredPolicy.get()


