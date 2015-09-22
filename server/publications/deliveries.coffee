Meteor.publishRelations 'deliveries',(qry)->
  check(@userId,String)
  check(qry,Match.Any)
  @cursor Deliveries.find(qry),(docId,doc)->
    if doc.files then @cursor eZFiles.find({_id:$in:doc.files})
    if doc.schedule
      @cursor Ratings.find({schedule:doc.schedule})
      @cursor Schedules.find(doc.schedule,CommonHelpers.getScheduleFieldsLight())
      null
  @ready()
