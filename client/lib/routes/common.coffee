Router.map ()->
  @route('home',
    path:Meteor.settings.public.appPath
  )

  @route('registrationSuccess',
    path:'/app/registerSuccess'
    layoutTemplate:'user_account'
  )

  @route('dashboard',
    path:'/app/dashboard'
  )
  null
