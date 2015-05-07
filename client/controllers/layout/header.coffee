Template.header.events
  'click .logout':(evt,temp)->
    Meteor.logout((err)->
      if err
        swal 'Logout Failure',err.message,'error'
    )
Template.header.helpers
  alerts:()->
    activities=Activities.find({isNew:true,audience:$in:[Meteor.userId()]}).fetch()
    notifications=_.groupBy(activities,'tag')
    _.map(notifications,(value,key)->
      {type:key,count:value.length,elapsed:value[0].createdAt}
    )

  alertCount:()->
    Activities.find({isNew:true,audience:$in:[Meteor.userId()]}).count()
