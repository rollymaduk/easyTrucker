###@bigSubs=new SubsManager({cacheLimit: 9999, expireIn: 9999});###

Router.configure {
  layoutTemplate:'main'

}
Router.onAfterAction(
  ->
    $.getScript('js/inspinia.js')
    null)
Router.map ()->
  @route('home',
  path:'/'
  data:->Schedules.find()
  waitOn:->Meteor.subscribe('scheduleList',50))

  @route('newSchedule',
  path:'/schedules/new'
  template:"manageSchedule")

  @route('editSchedule',
  path:'/schedules/edit/:_id',
  data:->Schedules.findOne(@params._id),
  waitOn:->Meteor.subscribe('scheduleItem',@params._id)
  template:"manageSchedule")

  @route('contactList',
  path:'/contactList'
  data:->Contacts.find()
  waitOn:->Meteor.subscribe('contactList',50))

  @route('truckList',
    path:'/truckList'
    data:->Trucks.find()
    waitOn:->Meteor.subscribe('truckList',50))

  @route('addContact',
    path:'/contact/new'
    template:"manageContact"
    )

  @route('addTruck',
    path:'/truck/new'
    template:"manageTruck"
  )
  null