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
      Meteor.users.find(bid.owner,{fields:profile:1,roles:1})
  ,
    find:(bid)->
      ###bid latest activity###
      Rp_Notification.getActivities({docId:bid._id,audience:$in:[userId]},{limit:1,sort:createdAt:-1})
  ,
    find:(bid)->
      Schedules.find(bid.schedule._id,{fields:{status:1,winningBid:1}})
  ]













