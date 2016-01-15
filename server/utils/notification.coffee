Eztrucker.Utils.Notification={
  getRequestNotificationRecipients:(doc,userId)->
    try
      check(doc,Schema.Schedule)
      switch doc.status
        when STATE_NEW
          res=_.map(doc.truckers,(item)->item.owner)
          {audience:res}
        when STATE_ASSIGNED
          {audience:[doc.owner,doc.resource.driver]}
        when STATE_BOOKED
          {audience:[doc.winningBid.bidder]}
        else
          res=CommonHelpers.getNotificationAudience(_.compact([doc?.winningBid?.bidder,doc?.owner,doc?.resource?.driver]),userId)
          {audience:res}
    catch err
      console.log err.message
      throw new Meteor.Error(1001,err.message)

  getRequestNotificationItems:(doc)->
    collection=COLLECTION_REQUEST
    try
      check(doc,Schema.Schedule)
      switch doc.status
        when STATE_NEW
          {title:TITLE_NEW,description:"Shipment request for #{doc.shipmentTitle}(#{doc.wayBill})"
            ,collection:collection,parent:doc._id}
        when STATE_BOOKED
          {title:TITLE_UPDATE,description:"You won a bid for shipment Request: #{doc.shipmentTitle}(#{doc.wayBill})"
            ,collection:collection,parent:doc._id}
        else
          {title:TITLE_UPDATE,description:"Shipment status changed to #{doc.status} for Request: #{doc.shipmentTitle}(#{doc.wayBill})"
            ,collection:collection,parent:doc._id}

    catch err
      console.log err.message
      throw new Meteor.Error(1002,err.message)


  getBidNotificationItems:(doc,isNew)->
    collection=COLLECTION_BID
    try
      check(doc,Schema.Bid)
      if isNew
        {parent:doc.schedule._id,title:TITLE_NEW, description:"Bid for #{doc.schedule.shipmentTitle}",collection:collection
          ,audience:[doc.schedule.owner]}
      else
       {parent:doc.schedule._id,title:TITLE_UPDATE, description:"Bid changed for #{doc.schedule.shipmentTitle}",collection:collection
         ,audience:[doc.schedule.owner]}
    catch err
      console.log err.message
      throw new Meteor.Error(1003,err.message)

  getNotificationLink:(collection,params)->
    switch collection
      when COLLECTION_BID
        Meteor.absoluteUrl("app/bids/view/#{params.id}")
      when COLLECTION_REQUEST
        Meteor.absoluteUrl("app/loads/view/#{params.id}")
      when COLLECTION_USER
        Meteor.absoluteUrl("#/verify-email/#{params.token}")

  getRequestReminderMessage:(request,refDate)->
    refDate=refDate or new Date()
    pickup=request.pickupDate.dateField_2 or request.pickupDate.dateField_1
    period=moment(moment(pickup)).from(moment(refDate))
    switch request.nextStep
      when STATE_EXPIRE
        {title:"#{request.wayBill} - Expires #{period}",description:"#{request.wayBill} - #{request.shipmentTitle} expires #{period}"}
      when STATE_DISPATCH
        {title:"#{request.wayBill} - Dispatches #{period}",description:"#{request.wayBill} - #{request.shipmentTitle} will dispatch #{period}"}
      when STATE_SUCCESS
        {title:"#{request.wayBill} - Delivers #{period}",description:"#{request.wayBill} - #{request.shipmentTitle} will deliver #{period}"}


  getRequestReminderAudience:(request)->
    switch request.nextStep
      when STATE_EXPIRE
        _.union(request.truckers.owner,[request.owner])
      when STATE_DISPATCH
        [request.owner,request.resource.driver,request.winningBid.bidder]
      when STATE_SUCCESS
        [request.owner,request.winningBid.bidder]

  getBaselineDate:(state,bidItem)->
    check(state,String)
    check(bidItem,Match.ObjectIncluding(schedule:Match.ObjectIncluding({dropOffDate:Object,pickupDate:Object})))
    switch state
      when STATE_EXPIRE,STATE_DISPATCH
        bidItem.schedule.pickupDate.dateField_2 or bidItem.schedule.pickupDate.dateField_1
      when STATE_SUCCESS
        bidItem.schedule.dropOffDate.dateField_2 or bidItem.schedule.dropOffDate.dateField_1

  filterUsersByReminderSettings:(users,baselineDate,refDate=new Date())->
    addresses=users.map (user)->
      if(_.intersection(user.settings.reminder,[STATE_EXPIRE,STATE_DISPATCH,STATE_SUCCESS]).length>0 and user.settings.reminderPeriod >= 1)
        if(moment.duration(user.settings.reminderPeriod,"days").beforeMoment(moment(baselineDate)).contains(moment(refDate)))
          user.emails[0].address
    _.compact(addresses)











}