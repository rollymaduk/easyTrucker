Template.cardList.rendered=->
  $('.footable').footable()



Template.cardList.helpers
  cards:->Rp_Payment.cards()
  payWithCardState:-> if Meteor.user().plan.payWithCard then 'checked' else null

Template.cardItem.events
  'click .change-card':(evt,temp)->
    Modal.show "changeCardModal",temp.data

Template.cardList.events
  'click .add-new-card':(evt,temp)->
    Modal.show "addCardModal",temp.data

  'change #togglePayWithCard':(evt,temp)->
    Rp_Payment.setPayWithCard(evt.target.checked,(err,res)->
      if err then toastr.error(err?.message, "Request failed!") else toastr.success(err?.message, "Request succeeded!");

    )





