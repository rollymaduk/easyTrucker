Router.map ()->
  @route('home',
    path:Meteor.settings.public.appPath
  )

  @route('registrationSuccess',
    path:'/app/registerSuccess'
    layoutTemplate:'user_account'
  )
  null
