Template.manageBid.created=->
  console.log @data
Template.manageBid.rendered=->
  that=@
  AutoForm.hooks
    placeBidForm:
      onSubmit:(insDoc,updDoc,currDoc)->
        Meteor.call 'placeBid',insDoc,(err,res)=>
          Router.go 'bidDetail',{_id:res}
          @done()
          null
        false
  ,true
  null