Template.manageDispatch.created=->
  unless @data._id
    @docType='insert'
  else
    @docType='update'

Template.manageDispatch.helpers
  dispatchDoc:->
    Template.currentData()
  docType:->
    Template.instance().docType