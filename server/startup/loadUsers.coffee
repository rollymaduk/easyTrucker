loadUser=(user)->
 ###Meteor.users.remove(username:user.username);###
 userAlreadyExists= _.isObject( Meteor.users.findOne({ username : user.username }))
 if (!userAlreadyExists)
  userId=Accounts.createUser(user)
  Roles.addUsersToRoles userId,'admin',Roles.GLOBAL_GROUP if userId
  null

Meteor.startup ()->
  users = YAML.eval(Assets.getText('users.yml'));
  _.each(users,(user)->
    loadUser(user)
  )