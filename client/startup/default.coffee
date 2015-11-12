Meteor.startup ->
  Impersonate.field1='profile.firstname'
  Impersonate.field2='profile.lastname'



  swal.setDefaults
    allowEscapeKey:true
    allowOutsideClick:true

  String.prototype.trimToLength = (m)->
    if(@length > m) then $.trim(@).substring(0, m).split(" ").slice(0, -1).join(" ") + "..." else @;

  Template.scheduleDate.replaces('afBootstrapDateTimePicker')


  Tracker.autorun ->
    roles=Meteor?.user()?.roles
    if roles
      role=_.values(roles)[0][0]
      RP_permissions.setCurrentRole(role)
      Session.set('currentRole',role)