Template.truckList.created=->
  params=Router.current().params
  filteredList=params?.trucks?.split(',')
  filter={filter:if filteredList then {_id:$in:filteredList} else {}}
  @handle=Meteor.paginatedSubscribe('trucks',filter,true,{perPage:10},()->
    console.log("subs ready!")
  )

Template.truckList.destroyed=->
  @handle.stop()

Template.truckList.helpers
  canLoadMore:()->
    Counts.get('total-trucks')>Trucks.find().count()

Template.truckList.events
  'click .load-more':(evt,temp)->
    temp.handle.loadNextPage()