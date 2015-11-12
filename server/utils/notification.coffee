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
          res=CommonHelpers.getNotificationAudience([doc.winningBid.bidder,doc.owner,doc.resource.driver],userId)
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
        when STATE_ASSIGNED
          {title:TITLE_NEW,description:"Assignment for shipment Request: #{doc.shipmentTitle}(#{doc.wayBill})"
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









}