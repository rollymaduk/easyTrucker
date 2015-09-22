Impersonate.field1='profile.firstname'
Impersonate.field2='profile.lastname'


swal.setDefaults
  allowEscapeKey:true
  allowOutsideClick:true

String.prototype.trimToLength = (m)->
  if(@length > m) then $.trim(@).substring(0, m).split(" ").slice(0, -1).join(" ") + "..." else @;

Template.scheduleDate.replaces('afBootstrapDateTimePicker')

Accounts.onLogin ->
  Tracker.autorun ->
    Session.set('currentRole',_.values(Meteor.user().roles)[0][0])

Tracker.autorun ->
  RP_permissions.setCurrentRole(Session.get('currentRole'))