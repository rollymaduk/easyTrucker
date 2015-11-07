Schedules.helpers
  state:->
   truckers=@truckers?.length
   if truckers and @status is STATE_NEW then STATE_MATCHED
   else if !truckers and @status is STATE_NEW then STATE_UNMATCHED
   else @status


  createRating:()->
    roles=Meteor?.user()?.roles
    if(_.contains(_.values(roles)[0],ROLE_TRUCKER) or _.contains(_.values(roles)[0],ROLE_DRIVER))
      audience=[@owner]
    else
      driver=@resource?.driver
      bidder=@winningBid?.bidder
      audience=_.compact(_.uniq([driver,bidder]))
    rating=Rp_Ratings.findOne({docId:@_id,createdBy:Meteor.userId()})
    if rating
      {id:rating._id}
    else
      {collection:COLLECTION_REQUEST,docId:@_id,audience:audience,name:"shipperRating"}

  performance:->
    res=Rp_Ratings.find({docId:@_id,audience:$in:[Meteor.userId()]}).map (doc)->
      doc.data
    res

  activities:->
    Rp_Notification.getActivities(20)

  latestActivity:()->
    Rp_Notifications.findOne({docId:@_id},{sort:createdAt:-1})

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

  truckSpecsVolume:()->
    CommonHelpers.getTruckVolume(@specs)

  files:->
    files=@memo?.files
    if files then eZFiles.find({_id:$in:files}).fetch() else []



