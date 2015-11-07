Meteor.publishRelations 'bids',(qry)->
  if @userId
   @cursor Bids.find(qry),(docId,doc)=>
     @cursor Meteor.users.find(doc.owner)
     @cursor Rp_Notification.getActivities({docId:docId,audience:$in:[@userId]},{limit:1,sort:createdAt:-1})
     null
   @ready()












