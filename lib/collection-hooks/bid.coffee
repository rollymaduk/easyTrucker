
collectionName=COLLECTION_BID


Bids.after.update (user,doc,fieldnames,modifier,options)->
  ###todo: add activity for bid updates###


Bids.after.insert (user,doc)->
  schedule=Schedules.findOne(doc.schedule)
  modifier= $inc:{totalBids:1},$addToSet:bidders:doc.owner
  qry=_id:doc.schedule
  Meteor.call "updateSchedule",qry,modifier,(err,res)->
    if res
      message="NEW[BID]: #{schedule.wayBill}-#{Meteor.user().company()}"
      activity={description:message,documentId:doc._id,collectionName:collectionName,audience:[schedule.owner]}
      Meteor.call 'createActivity',activity

