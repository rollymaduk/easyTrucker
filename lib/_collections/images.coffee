@eZImages = new FS.Collection("eZImages",
  stores: [new FS.Store.GridFS("eZImages", {})]
)
eZImages.allow
  insert: (userId, doc) ->
    true
  download: (userId,doc)->
    true
  update:(user,doc,fields,modifier)->
    true
  remove:(user,doc)->
    true