Schedules.helpers
  state:->
   truckers=@truckers?.length
   if truckers and @status is STATE_NEW then STATE_MATCHED
   else if !truckers and @status is STATE_NEW then STATE_UNMATCHED
   else @status

  canEditBeforeAcceptance:->
    @status is STATE_NEW
  createRating:()->
    switch Session.get('currentRole')
      when ROLE_TRUCKER,ROLE_DRIVER
        audience=[@owner]
      else
        driver=@resource?.driver
        bidder=@winningBid?.bidder
        audience=_.compact(_.uniq([driver,bidder]))
    canAddRating=Rp_Rating.getRatings({docId:@_id,createdBy:Meteor.userId()}).count()>0
    {collection:COLLECTION_REQUEST,class:"btn btn-primary btn-xs",docId:@_id,audience:audience,canAddRating:canAddRating,name:"shipperRating"}

  performance:->
    res=Rp_Ratings.find({docId:@_id,audience:$in:[Meteor.userId()]}).map (doc)->
      doc.data
    res or []

  activities:->
    Rp_Notification.getAllNotifications({parent:@_id},{sort:createdAt:-1},20)

  latestActivity:()->
    Rp_Notification.getAllNotifications({parent:@_id},{sort:createdAt:-1},1)[0] or {description:@shipmentTitle}

  matchedTrucks:->
    trucker=_.findWhere(@truckers,{owner:Meteor.userId()})
    trucker?.trucks or []

  bidCount:->
    @totalBids

  hasBid:->
    if(Meteor.userId())
      _.contains(@bidders,Meteor?.userId())

  notDirty:->
    @messages.length is 0 or @totalBids is 0

  canAssignResource:->
    @nextStep is STATE_ASSIGNED

  canManageBid:->
    RP_permissions.hasPermissions(['canCreatebid','canManagebid'])

  canCancelLoad:->
    !_.contains(NON_CANCEL_STATES,@status)

  truckSpecsVolume:()->
    CommonHelpers.getTruckVolume(@specs)

  truckSpecsWeight:()->
    CommonHelpers.getTruckWeight(@specs)

  shipper:->
    Meteor?.user()?.fullname()

  transporter:->
    Meteor.users.findOne(@winningBid?.bidder)?.fullname()






