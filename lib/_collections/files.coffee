@eZFiles = new FS.Collection("eZFiles",
  stores: [new FS.Store.GridFS("eZFiles", {})]
)
eZFiles.allow
  insert: (userId, doc) ->
    true
  download: (userId,doc)->
    true
  update:(user,doc,fields,modifier)->
    true
  remove:(user,doc)->
    true