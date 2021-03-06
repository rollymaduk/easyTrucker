Meteor.users.helpers
  isTrucker:->
    _.contains(_.values(@roles)[0],ROLE_TRUCKER)
  role:->
    if (Meteor.userId() is @_id) then Session.get('currentRole') else _.values(@roles)[0][0]
  unLoggedRoles:->
    _.without(_.values(@roles)[0],Session.get('currentRole'))
  company:->
    @profile.companyName
  fullname:()->
    "#{@profile.firstname} #{@profile.lastname}"
  getEmails:->
    @profile.emails.join()
  userProfile:()->
    _.extend(_.pick(@,'_id'),_.pick(@,'profile'))
  isActive:->
    @profile.isActive
  getRoles:->
    _.values(@roles)[0].join()
  defaultEmail:->@profile.emails[0]




