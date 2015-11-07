

Template.manageDelivery.helpers
  deliveryDoc:->
    Template.currentData()


Template.manageDelivery.rendered=->
  AutoForm.hooks
    manageDeliveryForm:
      onSubmit:(insertDoc,updDoc,currDoc)->
        that=@
        swal
          title:'Delivering Load!'
          text:"Deliver #{currDoc.subject}"
          showCancelButton: true,
          closeOnConfirm:false
        ,(isConfirmed)->
          if isConfirmed
            Meteor.call 'deliverLoad',insertDoc,(err,res)->
              Modal.hide()
              if  res then swal("Success", "Your delivery was successful",'success') else console.log err
              that.done()
              null
          else
            false
        false
  ,true
