
Template.bidListItem.helpers
  activity:->
    ###Activities.findOne({documentId:@_id},{sort:{createdAt:-1}})###

  message:->
    ###Messages.findOne({documentId:@_id},{sort:{createdAt:-1}})###

Template.bidList.helpers
  canInsert:()->
    RP_permissions.hasPermissions(['canCreatebid','canEditbid','canManagebid'])

  hasBid:->
    ###todo filter by schedule id during optimization###
    Bids.findOne({owner:Meteor.userId()})

  schedule:->
    Router.current().params._id

  canLoadMore:()->
    Counts.get('total-bids')>Bids.find().count()


Template.bidList.created=->
  params=Router.current().params
  @handle=Meteor.paginatedSubscribe('bids',{'schedule._id':params._id},{perPage:10},()->
    console.log("subs ready!")
  )

Template.bidList.destroyed=->
  @handle.stop()

Template.bidList.events
  'click .load-more':(evt,temp)->
    temp.handle.loadNextPage()









