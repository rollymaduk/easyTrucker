Meteor.publishComposite 'trucks',(qry,limit)->
  unless @userId
    return
  {filter,modifier}=qry
  filter=filter or {}
  modifier=modifier or {}
  _.extend(modifier,{limit:limit})
  _.extend(filter,{owner:@userId})
  find:()->
    cursor=Trucks.find(filter,modifier)
    Counts.publish(this, 'total-trucks', Trucks.find(filter),{onReady:true})
    cursor
  children:[
    find:(truck)->
      query='truckers.trucks':truck._id
      Schedules.find(query,{fields:{status:1,resource:1,_id:1,pickupDate:1,dropOffDate:1}})
    children:[
      find:(schedule,truck)->
        trucker=truck.owner
        Bids.find({'schedule._id':schedule._id,owner:trucker})
    ]
  ]



Meteor.publish 'truckItem',(id)->
  unless not @userId
    Trucks.find {_id:id,owner:@userId}

