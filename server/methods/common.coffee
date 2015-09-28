Meteor.methods
  sendCallToActionEmail:(to,subject,heading,message,buttonText,link)->
    this.unblock()
    audience=if _.isArray(to) then to else [to]
    _.each(audience,(val)->
      PrettyEmail.send 'call-to-action',
        to: val
        subject: subject
        heading: heading
        message: message
        buttonText: buttonText
        buttonUrl: link
    )




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