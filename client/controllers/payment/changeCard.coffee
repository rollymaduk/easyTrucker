AutoForm.hooks
  changeCardForm:
    onSubmit:(ins,upd,curr)->
      that=@
      Rp_Payment.changeCard(ins,(err,res)->
       console.log err or res
       if res
         toastr.success("Card detail successfully changed","Card change successfull")
       else
         toastr.error(err.message,"Card change failed")
       that.done()
       Modal.hide()
       return
      )
      false
  ,true

AutoForm.hooks
  addCardForm:
    onSubmit:(ins,upd,curr)->
      that=@
      console.log {source:ins}
      Rp_Payment.addCard({source:ins},(err,res)->
        if res
          toastr.success("Card detail successfully changed","Card change successfull")
        else
          toastr.error(err.message,"Card change failed")
        that.done()
        Modal.hide()
        return
      )
      false
,true