Template.scheduleDate.replaces('afBootstrapDateTimePicker')
Template.onRendered ()->

Template.main.destroyed=->
  Session.set('userType',null)
  Session.set('domainRoles',null)


Template.main.created=->

  swal.setDefaults
    allowEscapeKey:true
    allowOutsideClick:true

Template.main.rendered=->
  $.getScript('js/inspinia.js')
  String.prototype.trimToLength = (m)->
    if(@length > m) then $.trim(@).substring(0, m).split(" ").slice(0, -1).join(" ") + "..." else @;

Template.main.helpers
  hasProfile:()->
   profile= Meteor?.user()?.profile
   not _.isEmpty profile
