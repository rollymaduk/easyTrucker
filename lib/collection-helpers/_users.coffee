Meteor.users.helpers
  isTrucker:->
    _.contains(_.values(@roles)[0],ROLE_TRUCKER) if @roles

  stats:->
    {collection:"Schedules",name:"shipperRating",query:{audience:$in:[@_id]}}
  role:->
    if (Meteor?.userId() is @_id) then Session.get('currentRole') else _.values(@roles)[0][0] if @roles
  unLoggedRoles:->
    _.without(_.values(@roles)[0],Session.get('currentRole'))
  company:->
    unless @profile.companyName is TEXT_NONE then @profile.companyName
  fullname:()->
    "#{@profile.firstname} #{@profile.lastname}"
  getEmails:->
    @profile.emails.join()
  userProfile:()->
    _.extend(_.pick(@,'_id'),_.pick(@,'profile'))
  isActive:->
    @profile.isActive
  getRoles:->
    if @roles then _.values(@roles)[0].join()
  defaultEmail:->@profile.emails[0]




