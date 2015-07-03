Template.header.events
  'click .logout':(evt,temp)->
    Meteor.logout((err)->
      if err
        swal 'Logout Failure',err.message,'error'
    )

Template.header.created=->
  @alertCount=new ReactiveVar(0)
Template.header.helpers
  alerts:()->
    activities=Activities.find({isNew:true,audience:$in:[Meteor.userId()]}).fetch()
    notifications=_.groupBy(activities,'tag')
    alerts=_.flatten(_.map(notifications,(value,key)->
      switch key
        when NotifyTag.newRequest or NotifyTag.updateRequest
          ({parent:request.parentId,id:request.objectId,type:key,count:1,elapsed:request.createdAt} for request in value)
        when NotifyTag.newBid
          bids=_.groupBy(value,'parentId')
          _.map(bids,(value2,key2)->
            {parent:key2,id:null,type:key,count:value2.length,elapsed:value2[0].createdAt}
          )
        when NotifyTag.updateBid
          bids=_.groupBy(value,'objectId')
          _.map(bids,(value2,key2)->
            {parent:value2[0].parentId,id:key2,type:key,count:value2.length,elapsed:value2[0].createdAt}
          )


    ))
    Template.instance().alertCount.set(alerts.length)
    console.log alerts
    alerts


  alertCount:()->
    Template.instance().alertCount.get()
