Meteor.startup ->
  @ddpTruckSearch=Cluster.discoverConnection("eazytruckerAdmin")