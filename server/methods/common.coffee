Meteor.methods
  getAggregationResults:(collectionName,pipelines)->
    if _.isArray(pipelines) and _.isString(collectionName)
      try
        if pipelines.length
          _.map(pipelines,(pipeline)->
            Mongo.Collection.get(collectionName.toLowerCase()).aggregate(pipeline)
          )
        else null
      catch
        new Meteor.Error('mongo aggregation failure',_error.message)
    else
      new Meteor.Error('Invalid collection name or pipeline format','pipeline must be an array and collection name must be a string')