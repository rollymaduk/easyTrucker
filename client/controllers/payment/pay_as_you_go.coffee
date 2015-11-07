Template.payAsYouGo.events
  'click .pay-as-go':(evt,temp)->
    Eztrucker.Utils.Payment.pay(temp.data,Meteor.user().emails[0].address,Modal.hide())


AutoForm.hooks
  upgradeForm:
    onSubmit:(insDoc,updDoc,curDoc)->
      AppPlans.set(insDoc.plans)
      @done()
      false
