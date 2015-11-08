Router.configure {
  layoutTemplate:'main'
}

Router.onBeforeAction(
  ->
    GoogleMaps.load
      key: 'AIzaSyD8H4hG0fxQxnWSrH98AjThWLA14tqYB80',
      libraries: 'places'
    @next()
, { only: ['addTruck','editTruck','newSchedule','editSchedule','register','truckList'] }
)



Router.onBeforeAction ->
  Session.set('registerSubs',@params.hash) if @params.hash
  @next()
,{only:'atSignUp'}


Router.onAfterAction(
  ->
    $('body').toggleClass('gray-bg',_.isEmpty(Meteor.userId()))
    ###if Meteor.userId()then $('body').removeClass('gray-bg') else $('body').addClass('gray-bg')###
    null)