Template.scheduleList.helpers
  canInsert:()->
    roles=Meteor?.user()?.roles
    unless not roles then  _.contains(_.values(roles)[0],'shipper')


