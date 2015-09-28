Template.profileDetail.created=->
  @autorun ()->
    Meteor.call 'getAggregationResults','Ratings'
    ,CommonHelpers.getUserStatisticsQuery(Iron.controller().params._id),(err,res)->
      console.log err or res