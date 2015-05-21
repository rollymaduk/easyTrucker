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

  @route('register',
    path:'/app/user/register'
    layoutTemplate:'user_account'
    onAfterAction:()->
      $('.middle-box').toggleClass('loginscreen',false)
      $('.middle-box').toggleClass('registerscreen',true)
  )

  null