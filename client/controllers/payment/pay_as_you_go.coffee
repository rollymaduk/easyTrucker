Template.payAsYouGo.events
  'click .pay-as-go':(evt,temp)->
    ###Eztrucker.Utils.Payment.pay(temp.data,Meteor.user().emails[0].address,Modal.hide())###


AutoForm.hooks
  upgradeForm:
    onSubmit:(insDoc,updDoc,curDoc)->
      _that=@
      Rp_Payment.changePlan(insDoc.plans,(err,res)->
        if err then toastr.error(err?.message, "Plan change failed!") else toastr.success(err?.message, "Plan change successful!");
        _that.done()
      )
      false
