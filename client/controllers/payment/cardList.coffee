Template.cardList.rendered=->
  $('.footable').footable()

Template.cardList.helpers
  cards:->Session.get('cardList')

Template.cardItem.events
  'click .change-card':(evt,temp)->
    Modal.show "changeCardModal",temp.data



Template.cardList.created=->
  customerPlan=Meteor.user().appPlans
  {stripe}= customerPlan
  if stripe
    Eztrucker.Utils.Payment.getCustomerCards(stripe.customerId,(err,res)->
      if res then  Session.set('cardList',res) else console.log err
    )
