Meteor.methods
  registerNewUser:(user,role,groupName)->

    service= new UserAccountService()
    service.registerUser(user,role,groupName)

  updateUserProfile:(userId,profile)->
    service=new UserAccountService()
    service.updateProfile(userId,profile)

  updateProfileSetting:(userId,setting)->
    try
      check(userId,String)
      check(setting,Object)
      Meteor.users.update userId,{$set:settings:setting}
    catch
      throw new Meteor.Error "14100","Invalid input or user"

  toggleUserState:(user)->
    try
      check(user,Object)
      if user._id != @userId
        state=!user.profile.isActive
        Meteor.users.update user._id,{$set:'profile.isActive':state}
    catch
      throw new Meteor.Error 'invalid user access!'

  updateRoles:(user,roles)->
    try
      check(user,Match.OneOf(String,Object))
      check(@userId,String)
      check(roles,[String])
      group=Roles.getGroupsForUser(@userId)
      Roles.setUserRoles(user,roles,group[0])
      'done'
    catch err
      throw new Meteor.Error err.index,err.message

  userExists:(user)->
    !!Meteor.users.findOne($or:[{username:user},{emails:user}])