Template.manageDispatch.created=->
  console.log @data


Template.manageDispatch.helpers
  dispatchDoc:->
    Template.instance().data

Template.manageDispatch.rendered=->
  widget = uploadcare.Widget('[role=uploadcare-uploader]')
  widget.onUploadComplete (fileInfo)=>
    @data.photos=fileInfo.uuid

AutoForm.hooks
  manageDispatchForm:
    onSubmit:(insertDoc,updDoc,currDoc)->
      that=@
      swal
        title:'Dispatching Load!'
        text:"Dispatch #{currDoc.subject}"
        showCancelButton: true,
        closeOnConfirm:false
        ,(isConfirmed)->
          if isConfirmed
            Meteor.call 'dispatchLoad',insertDoc,(err,res)->
              Modal.hide()
              if  res then swal("Success", "Your dispatch was successful",'success') else console.log err
              that.done()
              null
          else
            false
      false
  ,true


