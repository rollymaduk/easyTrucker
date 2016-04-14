###todo reset cluster settings on GLOBAL_VAR settings during deployment###
unless Meteor.settings.public.useClusterVars
  Cluster.connect("mongodb://localhost:27017/discovery")
  Cluster.register("eazytruckerWeb")
  Cluster.allowPublicAccess("eazytruckerAdmin")



