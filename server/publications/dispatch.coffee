Meteor.publishRelations 'dispatches',(qry)->
  check(qry,Match.Any)
  @cursor Dispatches.find(qry),(docId,doc)->
    files=Meteor._get(doc,'files')
    @cursor eZFiles.find({_id:$in:files}) if files
    null
  @ready()
