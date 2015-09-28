getAverage=(item)->
  res=_.pick(item,TITLE_ACCURACY,TITLE_PERFORMANCE,TITLE_DELIVERY,TITLE_TIMELINESS)
  console.log res
  res=_.compact(_.values(res)).average()
  res.toFixed(1)
Ratings.before.insert (user,doc)->
  if Meteor.isServer
   doc.average= getAverage doc

Ratings.before.update (user,doc,fieldnames,modifier,options)->
  modifier.$set['average']= getAverage _.defaults(modifier.$set,doc)



