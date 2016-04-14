Meteor.startup ->
  @CloudspiderTags=new Meteor.Collection('goodTypes',ddpTruckSearch)
  @TruckTypes=new Meteor.Collection('trucks',ddpTruckSearch)
  @TruckAuthorizations=new Meteor.Collection('truckAuthorizations',ddpTruckSearch)
