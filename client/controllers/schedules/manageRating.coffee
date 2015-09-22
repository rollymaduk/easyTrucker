Template.manageRating.created=->
  console.log @data
AutoForm.debug()

Template.manageRating.rendered=->
  AutoForm.hooks
    manageRatingForm:
      onSuccess:(type,res)=>
        Router.go 'deliveryDetail',{_id:@data.schedule}