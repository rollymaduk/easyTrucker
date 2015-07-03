Template.sidebar.events
  'click .logout':(evt,temp)->
    Meteor.logout()


Template.sidebar.helpers
  links:->
    [
      {title:"Matched Loads",status:STATE_MATCHED,permissions:'canViewMatchedLoads'},
      {title:"Bidded Loads",status:STATE_BIDDED,permissions:'canViewBiddedLoads'},
      {title:"UnMatched Loads",status:STATE_UNMATCHED,permissions:'canViewUnmatchedLoads'},
      {title:"Unfulfilled Loads",children:[
        {status:STATE_BOOKED},
        {status:STATE_DISPATCH},
        {status:STATE_CANCELLED},
        {status:STATE_LATE},
      ]},
      {title:"Fulfilled Loads",children:[
        {status:STATE_ISSUE},
        {status:STATE_SUCCESS}
      ]}

    ]
  role:()->
    roles=Meteor?.user()?.roles
    if roles
      _.values(roles)[0][0]
    else null
  fullname:()->
    profile=Meteor?.user()?.profile
    "#{profile.firstname} #{profile.lastname}" if profile

