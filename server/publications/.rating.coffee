Meteor.publishRelations "ratings",(qry)->
  check @userId,String
  check(qry,Match.OneOf(String,Object))
  @cursor Ratings.find(qry),(docId,doc)->
    @cursor Schedules.find(doc.schedule,fields:{shipmentTitle:1,status:1,owner:1})
    null
  @ready()

