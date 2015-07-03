Router.map ()->
  @route('login',
    path:'/app/user/login'
    layoutTemplate:'user_account'
    onAfterAction:()->
      $('.middle-box').toggleClass('loginscreen',true)
      $('.middle-box').toggleClass('registerscreen',false)
  )



  @route('manageProfile',
    path:'/app/user/manageProfile'
    template:'manageProfile'
  )

  @route('profile',
    path:'/app/user/profile'
    template:'profileDetail'
    onBeforeAction:()->
     unless not Meteor.user()
       if _.isEmpty Meteor.user().profile then @render 'manageProfile'
       else
        @next()
       null

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