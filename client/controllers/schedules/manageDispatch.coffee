Template.manageDispatch.created=->
  unless @data._id
    @dispatchObj={schedule:@data.schedule}
    @docType='update'
  else
    @dispatchObj=@data
    @docType='insert'

Template.manageDispatch.helpers
  dispatchDoc:->
    Template.instance().dispatchObj
  docType:->
    Template.instance().docType