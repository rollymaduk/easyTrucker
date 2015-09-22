Template.manageContact.created=->
  console.log @data
  Session.set('contactObject',@data)

Template.manageContact.helpers
  contactDoc:->Session.get('contactObject')

Template.manageContact.events
  'click #locationmodal':(evt,temp)->
    obj=AutoForm.getFormValues('cf');
    Session.set('contactObject',obj.insertDoc)
    console.log Session.get 'contactObject'
    Modal.show 'placeModal','contact'
