Template.manageDelivery.created=->
  unless @data._id
    @deliveryObj={schedule:@data.schedule}
    @docType='insert'
  else
    @docType='update'

Template.manageDelivery.helpers
  deliveryDoc:->
    Template.currentData() or {schedule:@data.schedule}
  docType:->
    Template.instance().docType

Template.manageDelivery.rendered=->
  AutoForm.hooks
    manageDeliveryForm:
      onSuccess:(type,res)=>
        id=if _.isString(res) then res else @data.schedule
        Router.go 'deliveryDetail',{_id:id}
