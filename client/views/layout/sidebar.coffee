Template.sidebar.helpers
  role:()->
    roles=Meteor?.user()?.roles
    if roles
      _.values(roles)[0][0]
    else null
  fullname:()->
    profile=Meteor?.user()?.profile
    "#{profile.firstname} #{profile.lastname}" if profile

