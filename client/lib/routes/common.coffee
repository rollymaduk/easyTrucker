Router.map ()->
  @route('home',
    path:'/app'
  )

  @route('registrationSuccess',
    path:'/app/registerSuccess'
    layoutTemplate:'user_account'
  )
  null
