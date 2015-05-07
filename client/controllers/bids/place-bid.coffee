Template.placeBid.helpers
  formType:()->
    bidId=@?.bid?._id
    result=if bidId then 'update' else 'insert'
    console.log  result
    result