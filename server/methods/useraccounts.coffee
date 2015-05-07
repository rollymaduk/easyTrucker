Meteor.methods
  registerNewUser:(user,role)->
    service= new UserAccountService()
    service.registerUser(user,role)
  updateUserProfile:(userId,profile)->
    service=new UserAccountService()
    service.updateProfile(userId,profile)
