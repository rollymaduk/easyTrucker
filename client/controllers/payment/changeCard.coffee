AutoForm.hooks
  changeCardForm:
    onSubmit:(ins,upd,curr)->
      that=@
      Meteor.call 'changeCardDetails',curr.id,curr.customer,ins,(err,res)->
        if res
          toastr.success("Card detail successfully changed","Card change")
          Eztrucker.Utils.Payment.getCustomerCards(curr.customer,(error,result)->
            if result then Session.set('cardList',result) else console.log error
          )

        else
          toastr.error(err.message,"Card change")
          console.log err
        that.done()
        Modal.hide()
        return
      false
  ,true