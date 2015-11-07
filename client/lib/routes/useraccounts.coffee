Router.map ()->
  @route('manageProfile',
    path:'/user/manageProfile/:_id'
    template:'manageProfile'
    waitOn:->
      Meteor.subscribe('userInfo',@params._id)
    data:-> Meteor.users.findOne(@params._id)

  )

  @route('profile',
    path:'/user/profile/:_id'
    template:'profileDetail'
    waitOn:->
      Meteor.subscribe('userInfo',@params._id,true)
    data:->Meteor.users.findOne(@params._id)

  )

  @route('userList',
    path:'/user/userList'
    waitOn:->
      roles=Session.get('domainRoles')||null
      Meteor.subscribe 'userList',roles
    data:->Meteor.users.find()

  )

  @route('newUser',
    path:'/user/new'
    template:'manageUser'
  )

  ###@route('register',
    path:'/app/user/register'
    layoutTemplate:'user_account'
    onAfterAction:()->
      $('.middle-box').toggleClass('loginscreen',false)
      $('.middle-box').toggleClass('registerscreen',true)
  )###
  null

