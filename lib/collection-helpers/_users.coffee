Meteor.users.helpers
  isTrucker:->
    _.contains(_.values(@roles)[0],'trucker')
  role:->
    _.values(@roles)[0][0]
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



