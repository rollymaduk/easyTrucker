Router.map ()->
  @route('page',
    path:'/'
    onBeforeAction:()->
      @redirect '/landing/index.html'

    )