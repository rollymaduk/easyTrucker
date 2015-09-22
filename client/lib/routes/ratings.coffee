Router.map ()->
  @route('manageRating'
    path:'rating/:_id',
    onBeforeAction:()->
      if RP_permissions.hasPermissions(['canGiveFeedback'])
        @next()
      else
        @render "home"
        null
    template:"manageRating"
    data:->
      Ratings.findOne(@params._id)
    waitOn:->
      Meteor.subscribe('ratings',@params._id)
  )