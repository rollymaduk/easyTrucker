Template.truckList.created=->
  @handle=Meteor.paginatedSubscribe('trucks',{},{perPage:10},()->
    console.log("subs ready!")
  )

Template.truckList.helpers
  canLoadMore:()->
    Counts.get('total-trucks')>Trucks.find().count()

Template.truckList.events
  'click .load-more':(evt,temp)->
    console.log "hello"
    temp.handle.loadNextPage()