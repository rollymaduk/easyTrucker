Template.pickup.created=->
  Session.set('pickupObject',@data)



Template.pickup.helpers
  pickupDoc:->Session.get('pickupObject')
  type:->if(@._id) then 'update' else 'insert'


Template.pickup.events
  'click #usermodal':(evt,temp)->
    Modal.show 'contactListModal'
  'click #locationmodal':(evt,temp)->
    obj=AutoForm.getFormValues('puf');
    Session.set('pickupObject',obj.insertDoc)
    console.log Session.get 'pickupObject'
    Modal.show 'placeModal','pickup'

