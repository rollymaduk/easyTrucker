Schedules.helpers
  state:->
   truckers=@truckers?.length
   if truckers and @status is STATE_NEW then STATE_MATCHED
   else if !truckers and @status is STATE_NEW then STATE_UNMATCHED
   else @status

  commentInsertDoc:()->
    switch @status
      when STATE_NEW
        allAudience= _.map(@truckers,(doc)->doc.owner)
        allAudience.push(@owner)
        audience=CommonHelpers.getNotificationAudience(allAudience,Meteor.userId())
        console.log audience
        {parent:@_id,documentId:@_id,collectionName:COLLECTION_REQUEST,audience:audience}
      when STATE_BOOKED
        audience=CommonHelpers.getNotificationAudience([@winningBid.bidder,@owner],Meteor.userId())
        {parent:@_id,documentId:@winningBid.bid,collectionName:COLLECTION_REQUEST,audience:audience}
      when STATE_LATE,STATE_CANCELLED,STATE_ISSUE,STATE_SUCCESS
        null
      else
       audience=CommonHelpers.getNotificationAudience([@winningBid.bidder,@owner,@driver],Meteor.userId())
       {parent:@_id,documentId:@winningBid.bid,collectionName:COLLECTION_REQUEST,audience:audience}

  comments:()->
    Messages.find({documentId:@_id}).fetch()

  matchedTrucks:->
    trucker=_.findWhere(@truckers,{owner:Meteor.userId()})
    trucker?.trucks or []

  bidCount:->
    @totalBids

  hasBid:->
    if(Meteor.userId())
      _.contains(@bidders,Meteor.userId())

  notDirty:->
    @messages.length is 0 or @totalBids is 0
  canAssignResource:->
    @nextStep is STATE_ASSIGNED
  canManageBid:->
    RP_permissions.hasPermissions(['canCreatebid','canManagebid'])
  bid:->
    Bids.findOne({schedule:@_id,owner:Meteor.userId()})
  truckSpecsVolume:()->
    CommonHelpers.getTruckVolume(@specs)
  files:->
    files=@memo?.files
    if files then eZFiles.find({_id:$in:files}).fetch() else []
  activities:->
    Activities.find({documentId:@_id}).fetch()
  latestActivity:->
    Activities.findOne(parent:@_id,{limit:1,sort:{createdAt:-1}})
  latestMessage:->
    Messages.findOne({parent:@_id},{limit:1,sort:{createdAt:-1}})

