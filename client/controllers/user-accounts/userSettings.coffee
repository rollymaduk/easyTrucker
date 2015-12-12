setDefaultSound=(sound)->
  Session.set("user_sound",sound)

Template.userSettings.events
  "click .toggleNotificationButton":(evt,temp)->
    $(".toggleNotification").toggle();
  "click #test-notify":(evt,temp)->
    Rp_notify_js.show("Welcome #{Meteor.user().fullname()}", "Your notification is working fine!",true)
  "change [data-schema-key='defaultAlertSound']":(evt,temp)->
    sound=evt.target.value
    setDefaultSound(sound)
    ion.sound.play(sound)
  "click #enable-notification":(evt,temp)->

    if Rp_notify_js.needsPermission() then Rp_notify_js.setPermissions()


Template.userSettings.helpers
  settingsDoc:()->
    settings=Meteor?.user()?.settings
    settings or {}

Template.userSettings.rendered=->
  _canNotify=Meteor.user()?.settings?.canNotify
  canNotify=!Rp_notify_js.needsPermission() and _canNotify
  if canNotify then $(".toggleNotification").toggle();



AutoForm.hooks
  userSettingForm:
    onSubmit:(ins,upd,curr)->
      that=@
      ins.canNotify=$('#disable-notification').is(':visible')
      Meteor.call "updateProfileSetting",Meteor.userId(),ins,(err,res)->
        that.done()
        if res then Modal.hide() else console.log err
      false

