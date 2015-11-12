class @UserAccountService
  registerUser:(user,role,groupName)->
    ###{profile,username,password,email}=user
    newUser={username:username,password:password,email:email,profile:profile}###

    userId=Accounts.createUser(user)

    if userId
      groupName=groupName||username
      Roles.addUsersToRoles userId,role,groupName
      ###Accounts.sendVerificationEmail(userId)###
    userId

  updateProfile:(userId,profile)->
    console.log profile
    Schema.Profile.clean(profile)
    Meteor.users.update(userId,$set:{profile:profile})

