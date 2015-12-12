Template.sidebar.events
  'click .logout':(evt,temp)->
    console.log 'i am here as sidebar'
    Meteor.logout()

Template.toggleRoleItem.events
  'click .toggleRole':(evt,temp)->
    Session.set('currentRole',temp.data)

  'click .close-canvas-menu' :()->
    $('body').toggleClass("mini-navbar");


Template.sidebar.rendered=->
  $('#side-menu').metisMenu();

Template.sidebar.helpers
  links:->
    [
      {title:"Matched Loads",status:STATE_MATCHED,permissions:'canViewMatchedLoads'},
      {title:"Bidded Loads",status:STATE_BIDDED,permissions:'canViewBiddedLoads'},
      {title:"UnMatched Loads",status:STATE_UNMATCHED,permissions:'canViewUnmatchedLoads'},
      {title:"Unfulfilled Loads",children:[
        {status:STATE_BOOKED,permissions:'canViewAcceptedLoads'},
        {status:STATE_ASSIGNED},
        {status:STATE_DISPATCH},
        {status:STATE_CANCELLED},
        {status:STATE_EXPIRE},
        {status:STATE_LATE},
      ]},
      {title:"Fulfilled Loads",children:[
        {status:STATE_ISSUE},
        {status:STATE_SUCCESS}
      ]}

    ]


