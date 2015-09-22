Router.configure {
  layoutTemplate:'main'
  waitOn:()->
    Meteor.subscribe('notifications') if Meteor.userId()
    photo=Meteor?.user()?.profile?.photo
    Meteor.subscribe('eZImages',{_id:photo}) if photo
}

Router.onBeforeAction(
  ->
    GoogleMaps.load
      key: 'AIzaSyD8H4hG0fxQxnWSrH98AjThWLA14tqYB80',
      libraries: 'places'
    @next()
, { only: ['addTruck','editTruck','newSchedule','editSchedule','register','truckList'] }
)


Router.onAfterAction(
  ->
    console.log 'loaded inspinia!'
    $('body').toggleClass('gray-bg',_.isEmpty(Meteor.userId()))
    ###if Meteor.userId()then $('body').removeClass('gray-bg') else $('body').addClass('gray-bg')###
    null)