Template.paymentList.rendered=->
  $('.footable').footable()

Template.paymentList.helpers
  payments:->Rp_Payment.payments({},{limit:10,sort:{date:-1}})

