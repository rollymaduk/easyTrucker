Router.map ()->
  @route('home',
    path:Meteor.settings.public.appPath
  )

  @route('registrationSuccess',
    path:'/registerSuccess'
    layoutTemplate:'user_account'
  )

  @route('dashboard',
    path:'/dashboard'
  )

  @route('page',
    path:Meteor.settings.public.pagePath
    where:'server'
    action:()->
      html = SSR.render('layout')
      @response.writeHead 200,'Content-Type':'text/html'
      @response.end html
  )
  null
