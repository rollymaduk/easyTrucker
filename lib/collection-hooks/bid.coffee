collectionName=COLLECTION_BID
Bids.after.update (user,doc,fieldnames,modifier,options)->
  schedule=Schedules.findOne(doc.schedule)
  changes=_.pick(doc,'changes');
  FormatPeriod=(period)->
    d = (period+'').split(' ');
    ###["Tue", "Sep", "03", "2013", "21:54:52", "GMT-0500", "(Central", "Daylight", "Time)"]###
    [d[3], d[1], d[2], d[4]].join(' ');
    ###"2013 Sep 03 21:58:03"###
  if _.isArray(changes.changes)
    latestChange=changes.changes.pop()
    message=''
    _.map(latestChange.set,(val,key)->
      switch key
        when 'proposedDelivery','proposedPickup'
          _.map(val ,(val1 ,key1)->
            message="#{message} [#{key1} #{key}:#{val1.context} #{FormatPeriod(val1.dateField_1)} "
            message=if _.has(val1,'dateField_2') then "#{message} & #{FormatPeriod(val1.dateField_2)}]" else "#{message}]"
          )
        else
          _.map(val ,(val1 ,key1)->
            message="#{message} [#{key1} #{key}: #{val1}]"
          )
    )
    if message
      message="#{schedule.wayBill}|#{Meteor.user().company()}-#{message}"
      activity={parent:doc.schedule,title:"CHANGES[BID]",description:message,documentId:doc._id,collectionName:collectionName,audience:[schedule.owner]}
      Meteor.call 'createActivity',activity
  ###todo: add activity for bid up;dates###


Bids.after.insert (user,doc)->
  schedule=Schedules.findOne(doc.schedule)
  modifier= $inc:{totalBids:1},$addToSet:bidders:doc.owner
  qry=_id:doc.schedule
  Meteor.call "updateSchedule",qry,modifier,(err,res)->
    if res
      message="#{schedule.wayBill}-#{Meteor.user().company()}"
      activity={parent:doc.schedule,title:"NEW[BID]",description:message,documentId:doc._id,collectionName:collectionName,audience:[schedule.owner]}
      Meteor.call 'createActivity',activity

