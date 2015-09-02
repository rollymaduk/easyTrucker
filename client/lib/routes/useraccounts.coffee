Router.map ()->
  @route('login',
    path:'/app/user/login'
    layoutTemplate:'user_account'
    onAfterAction:()->
      $('.middle-box').toggleClass('loginscreen',true)
      $('.middle-box').toggleClass('registerscreen',false)
  )


  @route('manageProfile',
    path:'/app/user/manageProfile/:_id'
    template:'manageProfile'
    waitOn:->
      Meteor.subscribe('userInfo',@params._id)
      Meteor.subscribe('eZImages',{_id:photo})
    data:-> Meteor.users.findOne(@params._id)

  )

  @route('profile',
    path:'/app/user/profile/:_id'
    template:'profileDetail'
    waitOn:->
      Meteor.subscribe('userInfo',@params._id,true)
    data:->
      user=Meteor.users.findOne(@params._id)
      user
  )

  @route('userList',
    path:'/app/user/userList'
    waitOn:->
      roles=Session.get('domainRoles')||null
      Meteor.subscribe 'userList',roles
    data:->Meteor.users.find()

  )

  @route('newUser',
    path:'/app/user/new'
    template:'manageUser'
  )

  @route('register',
    path:'/app/user/register'
    layoutTemplate:'user_account'
    onAfterAction:()->
      $('.middle-box').toggleClass('loginscreen',false)
      $('.middle-box').toggleClass('registerscreen',true)
  )

  null