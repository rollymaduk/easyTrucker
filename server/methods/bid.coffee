Meteor.methods
  placeBid:(bid)->
    service=new TransactionService()
    service.addUpdateBids(bid)

  addBidComment:(bid,comment)->
    Form.Message.clean(comment)
    Bids.update(bid,$addToSet:messages:comment)
