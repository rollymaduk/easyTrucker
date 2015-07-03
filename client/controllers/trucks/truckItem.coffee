Template.truckItem.events
  'click #toggleSchedule':(evt,temp)->
    id=".#{temp.data._id}"
    $(id).toggle('slow');


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
