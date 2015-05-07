Meteor.methods
  placeBid:(bid)->
    service=new TransactionService()
    service.addUpdateBids(bid)

