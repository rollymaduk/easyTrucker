Template.userAccount.helpers
  canViewSubscription:->
    res=Router.current().params._id is Meteor.userId()
    console.log res
    res

