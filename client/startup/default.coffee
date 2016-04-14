String.prototype.trimToLength = (m)->
  @.split("-").join(" ")
  if(@length > m) then $.trim(@).substring(0, m).split(" ").slice(0, -1).join(" ") + "..." else @;

Meteor.startup ->
  Impersonate.field1='profile.firstname'
  Impersonate.field2='profile.lastname'

  loadUploadcare()
  ###load sound files###
  sounds=({name:sound} for sound in SOUNDS)
  ion.sound(
    sounds:sounds
    preload:false
    volume: 0.5
    path:"/sounds/"
  )
  Rp_notify_js.onShowNotification=()->
    sound=Session.get("user_sound")
    if sound
      ion.sound.play(sound)

  swal.setDefaults
    allowEscapeKey:true
    allowOutsideClick:true

  Template.scheduleDate.replaces('afBootstrapDateTimePicker')

  Tracker.autorun ->
    user=Meteor?.user()
    roles=user?.roles
    profile=user?.profile
    sound=user?.settings?.defaultAlertSound or "new_alert"
    Session.set("user_sound",sound)
    if roles
      role=_.values(roles)[0][0]
      RP_permissions.getPermissionsForRoles(role)
      Session.set('currentRole',role)
      {telephones}=profile
      console.log telephones
      telephones=telephones or []
      if telephones.length == 0 or telephones[0]==TEXT_NONE
        Session.set('registerComplete',false)
      else
        Session.set('registerComplete',true)
      ###load default sound###


  Tracker.autorun ->
    if Meteor.user()
      Rp_notify_js.notifyWhen=Meteor?.user()?.settings?.canNotify or false
      if Rp_notify_js.needsPermission()
        bootbar.danger2('<span class="text-center showUserSettings"><h5>Recommended: <a href="#" class="btn btn-warning btn-sm">
           Enable browser notifications</a> for your EazyTrucker alerts </h5></span>');
      else
        $(".close-bootbar").click();
      return


  Template.body.events
    'click .showUserSettings':(evt,data,temp)->
      Modal.show 'userSettingsModal'






