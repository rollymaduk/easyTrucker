Meteor.publishRelations 'bids',(qry,isLight=false,limit=10)->
  if @userId
   userId=@userId
   modifier=if  isLight then CommonHelpers.getBidFieldsLight() else {}
   @cursor Bids.find(qry,_.extend(modifier,{limit:limit})),(docId,doc)->
     @cursor Meteor.users.find(doc.owner)
     @cursor Rp_Notification.getActivities({docId:docId,audience:$in:[userId]},{limit:1,sort:createdAt:-1})
     null
   @ready()












