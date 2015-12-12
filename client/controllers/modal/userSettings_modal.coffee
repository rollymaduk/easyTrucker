Template.userSettingsModal.events
  'click .save-modal':(evt,temp)->
    console.log "hello"
    $("#userSettingForm").submit()