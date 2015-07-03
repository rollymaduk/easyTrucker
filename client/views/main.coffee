Template.scheduleDate.replaces('afBootstrapDateTimePicker')
Template.onRendered ()->

Template.main.destroyed=->
  Session.set('userType',null)
  Session.set('domainRoles',null)


Template.main.created=->
  @autorun ->
    Session.set 'domainRoles',null
    roles=Meteor?.user()?.roles
    if roles
     group=_.keys(roles)[0]
     if _.contains(_.values(roles)[0],'trucker')
      Session.set('domainRoles',{roles:['trucker','driver','accountant'],group:group})
      Session.set('userType','trucker')
     else if _.contains(_.values(roles)[0],'shipper')
      Session.set('domainRoles',{roles:['shipper','clerk'],group:group})
      Session.set('userType','shipper')



  swal.setDefaults
    allowEscapeKey:true
    allowOutsideClick:true

Template.main.rendered=->
  $.getScript('js/inspinia.js')

Template.main.helpers
  hasProfile:()->
   profile= Meteor?.user()?.profile
   not _.isEmpty profile
