

Template.manageDelivery.rendered=->
  AutoForm.hooks
    manageDeliveryForm:
      onSubmit:(insertDoc,updDoc,currDoc)->
        @done()
        Modal.hide()
        swal
          title:'Delivering Load!'
          text:"Deliver #{currDoc.subject}"
          showCancelButton: true,
          closeOnConfirm:false
        ,(isConfirmed)->
          if isConfirmed
            Meteor.call 'deliverLoad',insertDoc,(err,res)->
              if  res then swal("Success", "Your delivery was successful",'success') else console.log err
              null
          else
            false
        false
  ,true
