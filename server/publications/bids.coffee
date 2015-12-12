Meteor.publishComposite 'bids',(qry,isLight=false,limit=10)->
  unless @userId
    return
  userId=@userId
  modifier=if  isLight then CommonHelpers.getBidFieldsLight() else {}
  find:()->
    cursor=Bids.find(qry,_.extend(modifier,{limit:limit}))
    Counts.publish(this,'total-bids',Bids.find(qry))
    cursor
  children:[
    find:(bid)->
      ###bidders###
      Meteor.users.find(bid.owner)
    find:(bid)->
      ###bid latest activity###
      Rp_Notification.getActivities({docId:bid._id,audience:$in:[userId]},{limit:1,sort:createdAt:-1})
  ]













