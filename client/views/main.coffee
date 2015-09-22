Template.main.destroyed=->
  Session.set('userType',null)
  Session.set('domainRoles',null)


Template.main.created=->



Template.main.rendered=->
  $.getScript('js/inspinia.js')


Template.main.helpers
  hasProfile:()->
   profile= Meteor?.user()?.profile
   not _.isEmpty profile
