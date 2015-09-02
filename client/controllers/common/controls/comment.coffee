AutoForm.hooks
  newCommentForm:
    onSubmit:(ins,upd,curr)->
      Meteor.call 'manageMessage',ins,@docId,(err,res)=>
        console.log err or res
        @done()
      false
