Template.manageBid.rendered=->
  that=@
  AutoForm.hooks
    placeBidForm:
      onSubmit:(insDoc,updDoc,currDoc)->
        ###unless insDoc.schedule then insDoc.schedule=that.data.schedule###
        ###insDoc._id=@docId###
        ###console.log insDoc###
        console.log insDoc
        console.log currDoc
        Meteor.call 'placeBid',insDoc,(err,res)=>
          Router.go 'bidDetail',{_id:res}
          @done()
          null
        false
  ,true
  null