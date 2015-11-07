SSR.compileTemplate('layout', Assets.getText('landing/index.html'));

Template.layout.helpers
  getDocType:()->
    "<!DOCTYPE html>";

  appPath:()->Meteor.settings.public.appPath
