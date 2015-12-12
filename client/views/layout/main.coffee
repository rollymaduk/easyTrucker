Template.main.destroyed=->
  Session.set('userType',null)
  Session.set('domainRoles',null)

Template.main.created=->
  @autorun ->
    unless Session.get("registerComplete") then Modal.show 'registerStep2Modal' else Modal.hide()

Template.main.rendered =->
  # Minimalize menu when screen is less than 768px
  $(window).bind 'resize load', ->
    if $(this).width() < 769
      $('body').addClass 'body-small'
    else
      $('body').removeClass 'body-small'
    return
  # Fix height of layout when resize, scroll and load
  $(window).bind 'load resize scroll', ->
    if !$('body').hasClass('body-small')
      navbarHeigh = $('nav.navbar-default').height()
      wrapperHeigh = $('#page-wrapper').height()
      if navbarHeigh > wrapperHeigh
        $('#page-wrapper').css 'min-height', navbarHeigh + 'px'
      if navbarHeigh < wrapperHeigh
        $('#page-wrapper').css 'min-height', $(window).height() + 'px'
      if $('body').hasClass('fixed-nav')
        $('#page-wrapper').css 'min-height', $(window).height() - 60 + 'px'
    return
  # SKIN OPTIONS
  # Uncomment this if you want to have different skin option:
  # Available skin: (skin-1 or skin-3, skin-2 deprecated, md-skin)
  # $('body').addClass('md-skin');
  # FIXED-SIDEBAR
  # Uncomment this if you want to have fixed left navigation
  # $('body').addClass('fixed-sidebar');
  # $('.sidebar-collapse').slimScroll({
  #     height: '100%',
  #     railOpacity: 0.9
  # });
  # BOXED LAYOUT
  # Uncomment this if you want to have boxed layout
  # $('body').addClass('boxed-layout');
  return





Template.main.helpers
  hasProfile:()->
   profile= Meteor?.user()?.profile
   not _.isEmpty profile