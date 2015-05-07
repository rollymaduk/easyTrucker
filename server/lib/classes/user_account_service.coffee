class @UserAccountService
  registerUser:(user,role)->
    {username,password,email}=user
    newUser={username:username,password:password,email:email}
    userId=Accounts.createUser(newUser)
    if userId
      Roles.addUsersToRoles userId,[role,'admin'],username
      Accounts.sendVerificationEmail(userId)
    userId

  updateProfile:(userId,profile)->
    Schema.Profile.clean(profile)
    Meteor.users.update(userId,$set:{profile:profile})

