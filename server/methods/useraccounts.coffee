Meteor.methods
  registerNewUser:(user,role,groupName)->
    service= new UserAccountService()
    service.registerUser(user,role,groupName)
  updateUserProfile:(userId,profile)->
    console.log profile
    service=new UserAccountService()
    service.updateProfile(userId,profile)
  toggleUserState:(user)->
    if user.profile and  Meteor.userId() != user._id
      state=!user.profile.isActive
      Meteor.users.update user._id,{$set:'profile.isActive':state}
    else
      throw new Meteor.Error 'invalid user access!'
  updateRoles:(user,roles)->
    if user and Meteor.userId()
      Roles.setUserRoles(user,roles,Meteor.user().username)
      'done'
    else
      throw new Meteor.Error 'invalid user access!'