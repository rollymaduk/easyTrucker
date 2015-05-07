Template.sidebar.helpers
  role:()->
    roles=Meteor?.user()?.roles
    if roles
      _.values(roles)[0][0]
    else null