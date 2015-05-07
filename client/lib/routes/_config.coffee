Router.configure {
  layoutTemplate:'main'
  waitOn:()->
    Meteor.subscribe('notifications',Meteor.userId()) if Meteor.userId()
  loadingTemplate:'loading'
}

Router.onBeforeAction(
  ->
    unless Meteor.userId()
      @layout 'user_account'
      @render 'login'
      ###Router.go 'login'###
      null
    else
      @next()
      null
,{except: ['login','register','registrationSuccess','page']}
)


Router.onAfterAction(
  ->
    $.getScript('js/inspinia.js')
    $('body').toggleClass('gray-bg',_.isEmpty(Meteor.userId()))
    ###if Meteor.userId()then $('body').removeClass('gray-bg') else $('body').addClass('gray-bg')###
    null)