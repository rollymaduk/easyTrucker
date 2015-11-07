collectionName=COLLECTION_BID
Bids.after.update (user,doc,fieldnames,modifier,options)->
  Meteor.call "sendBidNotification",doc



Bids.after.insert (user,doc)->
  modifier= $inc:{totalBids:1},$addToSet:bidders:doc.owner
  qry=_id:doc.schedule._id
  console.log doc
  Meteor.call "updateSchedule",qry,modifier,(err,res)->
    Meteor.call 'sendBidNotification',doc,true if res

