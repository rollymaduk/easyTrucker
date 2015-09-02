Template.manageDispatch.created=->
  unless @data._id
    @dispatchObj={schedule:@data.schedule}
  else
    @dispatchObj=@data

Template.manageDispatch.helpers
  dispatchDoc:->
    Template.instance().dispatchObj
