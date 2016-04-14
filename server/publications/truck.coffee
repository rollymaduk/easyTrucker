Meteor.publishComposite 'trucks',(qry,isLight=false,limit)->
  unless @userId
    return
  {filter,modifier}=qry
  console.log modifier
  filter=filter or {}
  modifier=modifier or {}
  unless isLight then _.extend(modifier,{limit:limit}) else _.extend(modifier,{limit:limit},CommonHelpers.getTruckFieldsLight())
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

