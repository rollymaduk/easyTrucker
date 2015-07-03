Meteor.users.helpers
  company:->
    @profile.companyName
  fullname:()->
    "#{@profile.firstname} #{@profile.lastname}"
  getEmails:->
    @profile.emails.join()

  isActive:->
    @profile.isActive

  getRoles:->
    _.values(@roles)[0].join()



