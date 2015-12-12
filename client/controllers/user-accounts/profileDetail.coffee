Template.profileDetail.created=->
   id=Router.current().params._id
   @subscribe('userInfo',id,true)

Template.profileDetail.helpers
  info:()->
    id=Router.current().params._id
    Meteor.users.findOne(id)

  ratingListQuery:->
    id=Router.current().params._id
    {audience:$in:[id]}

