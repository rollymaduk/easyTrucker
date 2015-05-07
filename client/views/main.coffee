Template.scheduleDate.replaces('afBootstrapDateTimePicker')
Template.main.created=->
  swal.setDefaults
    allowEscapeKey:true
    allowOutsideClick:true

Template.main.helpers
  hasProfile:()->
   profile= Meteor?.user()?.profile
   not _.isEmpty profile
