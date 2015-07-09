Router.map ()->
  @route('home',
    path:'/'
  )

  @route('registrationSuccess',
    path:'/app/registerSuccess'
    layoutTemplate:'user_account'
  )
  null
