Template.manageDispatch.created=->
  console.log @data


AutoForm.hooks
  manageDispatchForm:
    onSubmit:(insertDoc,updDoc,currDoc)->
      @done()
      Modal.hide()
      swal
        title:'Dispatching Load!'
        text:"Dispatch #{currDoc.subject}"
        showCancelButton: true,
        closeOnConfirm:false
        ,(isConfirmed)->
          if isConfirmed
            Meteor.call 'dispatchLoad',insertDoc,(err,res)->
              if  res then swal("Success", "Your dispatch was successful",'success') else console.log err
              null
          else
            false
      false
  ,true


AutoForm.debug()