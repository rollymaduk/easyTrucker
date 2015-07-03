if Meteor.isServer
  Router.map ()->
    @route('page',
      path:'/'
      where:'server'
      action:()->
         html = SSR.render('layout')
         @response.writeHead 200,'Content-Type':'text/html'
         @response.end html
    )
  null
