setAddressForLocation=(sessionToken,formId,objectProperty,placeObject)->
  loc=Session.get(sessionToken)
  loc[objectProperty]=placeObject
  Session.set(sessionToken,loc)
  AutoForm.resetForm(formId)

Template.placeModal.events
  'click .save-modal':(evt,temp)->
    location=AutoForm.getFormValues('pf').insertDoc.address
    console.log location
    switch temp.data
      when 'pickup'
        setAddressForLocation('pickupObject','puf','pickupLocation',location)
      when 'contact'
        setAddressForLocation('contactObject','cf','address',location)
      else
        setAddressForLocation('dropOffObject','dof','dropOffLocation',location)
    Modal.hide()

