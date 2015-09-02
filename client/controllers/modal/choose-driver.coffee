Template.chooseDriverModal.created=->
  Template.chooseDriverModal.datasource=@data.data.drivers
  console.log Template.chooseDriverModal.datasource
Template.chooseDriverModal.helpers
  ###todo improve on driver selection to include images###
  driverSelectize:()->
    options: ()->
      Template.chooseDriverModal.datasource
    valueField: "_id"
    render:
      option:(item,escape)->
        console.log item
        Blaze.toHTMLWithData(Template.chooseDriverItem,item.profile)

      item:(item,escape)->
        "<div>#{escape(item.profile.firstname)} #{escape(item.profile.lastname)}</div>"



Template.chooseDriverModal.events
  'click .save-modal':(evt,temp)->
    schedule=Session.get('acceptedRequestItem').schedule
    driver=AutoForm.getFormValues('chooseDriverForm').insertDoc.driver
    resource={driver:driver,truck:temp.data.data.truck}
    console.log resource
    Meteor.call 'assignResource',resource,schedule,(err,res)->
      if res then Modal.hide(temp) else console.log err






