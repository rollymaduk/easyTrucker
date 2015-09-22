Template.manageBid.created=->

Template.manageBid.rendered=->
  that=@
  AutoForm.hooks
    placeBidForm:
      onSubmit:(insDoc,updDoc,currDoc)->
        isValid=if currDoc.maximumBidPrice then currDoc.maximumBidPrice>=insDoc.quote else true
        unless isValid
          bidSchemaContext.addInvalidKeys [{name:'quote',type:'invalidQuote'}]
          @done()
          false
        else
          insDoc._id=currDoc?._id
          Meteor.call 'placeBid',insDoc,(err,res)=>
            id=insDoc._id or res
            Router.go 'bidDetail',{_id:id}
            @done()
            null
          false
  ,true
  null