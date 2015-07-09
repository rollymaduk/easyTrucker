AutoForm.hooks
  bidCommentsForm:
    onSubmit:(ins,upd,curr)->
      Meteor.call 'addBidComment',@docId,ins,(err,res)=>
        console.log err or res
        @done()
      false