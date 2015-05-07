Router.map ()->
  @route('truckList',
    path:'/app/truckList'
    data:->Trucks.find()
    waitOn:->Meteor.subscribe('truckList',50))

  @route('addTruck',
    path:'/app/truck/new'
    template:"manageTruck"
  )

  null