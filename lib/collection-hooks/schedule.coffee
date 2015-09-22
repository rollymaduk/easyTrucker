collectionName=COLLECTION_REQUEST
Schedules.after.insert (user,doc)->
  message= "#{doc.wayBill}-#{doc.shipmentTitle} "
  activity={parent:doc._id,title:doc.status.toUpperCase(),description:message,documentId:doc._id,collectionName:collectionName,audience:_.map(doc.truckers,(item)->item.owner)}
  Meteor.call 'createActivity',activity

Schedules.after.update (user,doc,fieldnames,mod,options)->
  if _.contains(fieldnames,'status')
    doc=@transform()
    previous=@transform(@previous)
    state=doc.state
    unless _.isEqual(previous.state,state)
      message= "#{doc.state.toUpperCase()}: #{doc.wayBill}-#{doc.shipmentTitle}"
      switch doc.status
        when doc.status is STATE_NEW
          audience=CommonHelpers.getNotificationAudience(_.map(doc.truckers,(doc)->doc.owner).push(doc.owner),Meteor.userId())
        when doc.status is STATE_ACCEPTED
          audience=CommonHelpers.getNotificationAudience([doc.winningBid.bidder,doc.owner],Meteor.userId())
        else  audience=CommonHelpers.getNotificationAudience([doc.winningBid.bidder,doc.owner,doc.driver],Meteor.userId())

      activity={parent:doc._id,title:doc.state.toUpperCase(),description:message,documentId:doc._id,collectionName:collectionName,audience:audience}
      Meteor.call 'createActivity',activity