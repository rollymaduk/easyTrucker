Template.topNavbar.events
  'click .logout':(evt,temp)->
    Meteor.logout((err)->
      if err
        swal 'Logout Failure',err.message,'error'
    )

  'click #navbar-minimalize':(event,temp)->
    event.preventDefault();
    $("body").toggleClass("mini-navbar");

    if (!$('body').hasClass('mini-navbar') || $('body').hasClass('body-small'))
      $('#side-menu').hide();
      setTimeout(()->
        $('#side-menu').fadeIn(500)
      ,100);
    else if ($('body').hasClass('fixed-sidebar'))
      $('#side-menu').hide()
      setTimeout(()->
        $('#side-menu').fadeIn(500)
      ,300);
    else
      $('#side-menu').removeAttr('style');




  'click .right-sidebar-toggle':(evt,temp)->
    $('#right-sidebar').toggleClass('sidebar-open')



Template.topNavbar.helpers
  alerts:()->
    Rp_Notification.getAlerts({collection:$in:[COLLECTION_REQUEST,COLLECTION_BID]})

  messages:()->
    Rp_Notification.getAlerts({collection:COLLECTION_COMMENT})


