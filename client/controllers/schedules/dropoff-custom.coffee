Template.dropOff.created=->
  console.log @data
  Session.set('dropOffObject',@data)

Template.dropOff.helpers
  dropOffDoc:->Session.get('dropOffObject')

Template.dropOff.rendered=->
  @autorun ->
    if GoogleMaps.loaded()
      $('input[data-schema-key="dropOffLocation.address"]').geocomplete
        details:".geometry"
        detailsAttribute:"data-geo"
      null


Template.dropOff.events
  'click #usermodal':(evt,temp)->
    Modal.show 'contactListModal'
  'click #locationmodal':(evt,temp)->
    obj=AutoForm.getFormValues('dof');
    Session.set('dropOffObject',obj.insertDoc)
    console.log Session.get 'dropOffObject'
    Modal.show 'placeModal','dropOff'

