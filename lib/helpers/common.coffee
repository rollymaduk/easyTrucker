@CommonHelpers={}


CommonHelpers.generateUsername=(useremail,companyName)->
  email=useremail.replace(/[`~!@#$%^&*()_|+\-=?;:'",.<>\{\}\[\]\\\/]/gi, '')
  company=companyName.replace(/[`~!@#$%^&*()_|+\-=?;:'",.<>\{\}\[\]\\\/]/gi, '')
  part1=email.substr(0,3)

  part2=email.substr(5,3) if email.length>5

  part3=company.substr(0,3)

  part1.concat(part2,part3)

CommonHelpers.generatePassword=()->
  'password'

CommonHelpers.getAllRoles=(type)->
  switch type
    when ROLE_SHIPPER then [{value:'clerk',label:'Clerk'},{value:'shipper',label:'Administrator'}]
    when ROLE_TRUCKER then [{value:'driver',label:'Driver'},{value:'accountant',label:'Accountant'},{value:ROLE_TRUCKER,label:'Administrator'}]
    else []

CommonHelpers.getNotificationAudience=(users,exclude)->
  users=if _.isArray(users) then users else []
  morethanOnce=(users.join('').split(exclude).length-1)>1
  unless morethanOnce then _.without(users,exclude) else _.unique(users)

CommonHelpers.getTruckVolume=(context)->
  if context.boxedVolume
    width=Converters.convertSizeFromFeet(context.boxedVolume.width,context.boxedVolume.metric)
    length=Converters.convertSizeFromFeet(context.boxedVolume.length,context.boxedVolume.metric)
    height=Converters.convertSizeFromFeet(context.boxedVolume.height,context.boxedVolume.metric)

    "W:#{width}#{context.boxedVolume.metric} x L:#{length}#{context.boxedVolume.metric} x H:#{height}#{context.boxedVolume.metric}"
  else if context.liquidVolume
    value=Converters.convertVolumeFromLitre(context.liquidVolume.value,context.liquidVolume.metric)
    "#{value}#{context.liquidVolume.metric}"
  else 'nil'

CommonHelpers.buildFilterQry=(filters)->
  query=filter:{}
  groups={}
  _.each(filters,(doc)->
    if  doc.field
      myOp={}
      if doc.operator
        myOp[doc.operator]=doc.value
      else
        myOp=doc.value
      myFilter={}
      myFilter[doc.field]=myOp
      if doc.group and doc.condition
        groups[doc.group][doc.condition]=[myFilter]
      else if doc.parent
        operator=_.keys(groups[doc.parent])[0]
        if _.isArray(operator)
          groups[doc.parent][operator].push(myFilter)
      else
        _.extend(query.filter,myFilter)
  )
  _.each(groups,(group)->
    _.extend(query.filter,group)
  )
  query

CommonHelpers.getFiltersForSchedule=(key)->
  qryObj=[]
  switch key
    when STATE_BIDDED,STATE_UNMATCHED,STATE_MATCHED then qryObj.push({field:'status',value:STATE_NEW})
    else qryObj.push({field:'status',value:key})
  switch key
    when STATE_BIDDED then qryObj.push({field:'bidders',value:Meteor.userId()})
    when STATE_UNMATCHED then qryObj.push({field:'truckers',value:0,operator:'$size'})
    when STATE_MATCHED
      unless Meteor.user().isTrucker() then qryObj.push({field:'truckers.owner',value:true,operator:'$exists'})
    else
      switch Meteor.user().role()
        when ROLE_TRUCKER then qryObj.push({field:'winningBid.bidder',value:Meteor.userId()})
  @buildFilterQry(qryObj)


CommonHelpers.getFiltersForTrucks=(key)->
  @buildFilterQry([{field:'_id',value:key?.split(",") or [],operator:'$in'}])

CommonHelpers.getScheduleFieldsLight=()->
  {fields:{dropOffLocation:1,pickupLocation:1,totalBids:1,truckers:1,bidders:1
    ,wayBill:1,status:1,shipmentTitle:1,owner:1,pickupDate:1,dropOffDate:1
    ,maximumBidPrice:1,receiver:1,sender:1,winningBid:1,resource:1,nextStep:1}}

CommonHelpers.getBidFieldsLight=->
  {fields:{'schedule._id':1,'schedule.owner':1,'schedule.shipmentTitle':1,quote:1,owner:1}}

CommonHelpers.getDashboardMetricsQuery=(role)->
  colors={matched:'#f8ac59',success:'#1ab394',late:'#ED5565'
    ,accepted:'#9370db',issue:'#EE82EE',cancel:'#c2c2c2',assigned:'#23c6c8',request:'#1c84c6'}
  switch role
    when ROLE_TRUCKER
      [
        [
          {$match:{'truckers.owner':$in:[Meteor.userId()]}}
          {$group:{_id:null,matched:$sum:1}}
          {$project:{_id:0,title:{$literal:"Matched"},description:{$literal:"Total number of matched Requests"}
            ,color:{$literal:colors.matched},value:"$matched"}}
        ]
        [
          {$match:{'winningBid.bidder':Meteor.userId()}}
          {$group:{_id:null,accepted:$sum:1}}
          {$project:{_id:0,title:{$literal:"Accepted"},description:{$literal:"Total number of accepted Bids"}
            ,color:{$literal:colors.accepted},value:"$accepted"}}
        ]
        [
          {$match:{'winningBid.bidder':Meteor.userId(),status:STATE_SUCCESS}}
          {$group:{_id:null,delivered:$sum:1}}
          {$project:{_id:0,title:{$literal:"Delivered"},description:{$literal:"Total number of successful Deliveries"}
            ,color:{$literal:colors.success},value:"$delivered"}}
        ]
        [
          {$match:{'winningBid.bidder':Meteor.userId(),isLate:true}}
          {$group:{_id:null,late:$sum:1}}
          {$project:{_id:0,title:{$literal:"Late"},description:{$literal:"Total number of Late Deliveries"}
            ,color:{$literal:colors.late} ,value:"$late"}}
        ]
        [
          {$match:{'winningBid.bidder':Meteor.userId(),status:STATE_ISSUE}}
          {$group:{_id:null,issues:$sum:1}}
          {$project:{_id:0,title:{$literal:"Issues"},description:{$literal:"Total number of deliveries with Issues"}
            ,color:{$literal:colors.issue},value:"$issues"}}
        ]
        [
          {$match:{'winningBid.bidder':Meteor.userId(),status:STATE_CANCELLED}}
          {$group:{_id:null,cancelled:$sum:1}}
          {$project:{_id:0,title:{$literal:"Cancelled"},description:{$literal:"Total number of Cancelled Requests"}
            ,color:{$literal:colors.cancel},value:"$cancelled"}}
        ]

      ]
    when ROLE_SHIPPER
      [
        [
          {$match:{owner:Meteor.userId()}}
          {$group:{_id:null,requests:$sum:1}}
          {$project:{title:{$literal:"Requests"},description:{$literal:"Total number of Requests"}
            ,color:{$literal:colors.request},value:"$requests"}}
        ]
        [
          {$match:{owner:Meteor.userId(),$nor:[truckers:{$exists:false},{truckers:$size:0}]}}
          {$group:{_id:null,matched:$sum:1}}
          {$project:{title:{$literal:"Matched"},description:{$literal:"Total number of matched Requests"}
            ,color:{$literal:colors.matched},value:"$matched"}}
        ]
        [
          {$match:{'owner':Meteor.userId(),status:STATE_SUCCESS}}
          {$group:{_id:null,delivered:$sum:1}}
          {$project:{_id:0,title:{$literal:"Delivered"},description:{$literal:"Total number of successful Deliveries"}
            ,color:{$literal:colors.success},value:"$delivered"}}
        ]
        [
          {$match:{'owner':Meteor.userId(),isLate:true}}
          {$group:{_id:null,late:$sum:1}}
          {$project:{_id:0,title:{$literal:"Late"},description:{$literal:"Total number of Late Deliveries"}
            ,color:{$literal:colors.late},value:"$late"}}
        ]
        [
          {$match:{'owner':Meteor.userId(),status:STATE_ISSUE}}
          {$group:{_id:null,issues:$sum:1}}
          {$project:{_id:0,title:{$literal:"Issues"},description:{$literal:"Total number of deliveries with Issues"}
            ,color:{$literal:colors.issue},value:"$issues"}}
        ]
        [
          {$match:{'owner':Meteor.userId(),status:STATE_CANCELLED}}
          {$group:{_id:null,cancelled:$sum:1}}
          {$project:{_id:0,title:{$literal:"Cancelled"},description:{$literal:"Total number of Cancelled Requests"}
            ,color:{$literal:colors.cancel},value:"$cancelled"}}
        ]
      ]
    when ROLE_DRIVER
      [
        [
          {$match:{'resource.driver':Meteor.userId(),status:STATE_ASSIGNED}}
          {$group:{_id:null,assigned:$sum:1}}
          {$project:{title:{$literal:"Assigned"},description:{$literal:"Total number of assigned Requests"}
            ,color:{$literal:colors.assigned},value:"$assigned"}}
        ]
        [
          {$match:{'resource.driver':Meteor.userId(),status:STATE_SUCCESS}}
          {$group:{_id:null,delivered:$sum:1}}
          {$project:{title:{$literal:"Delivered"},description:{$literal:"Total number of successful Deliveries"}
            ,color:{$literal:colors.success},value:"$delivered"}}
        ]
        [
          {$match:{'resource.driver':Meteor.userId(),isLate:true}}
          {$group:{_id:null,late:$sum:1}}
          {$project:{_id:0,title:{$literal:"Late"},description:{$literal:"Total number of Late Deliveries"}
            ,color:{$literal:colors.late},value:"$late"}}
        ]
        [
          {$match:{'resource.driver':Meteor.userId(),status:STATE_ISSUE}}
          {$group:{_id:null,issues:$sum:1}}
          {$project:{_id:0,title:{$literal:"Issues"},description:{$literal:"Total number of deliveries with Issues"}
            ,color:{$literal:colors.issue},value:"$issues"}}
        ]
        [
          {$match:{'resource.driver':Meteor.userId(),status:STATE_CANCELLED}}
          {$group:{_id:null,cancelled:$sum:1}}
          {$project:{_id:0,title:{$literal:"Cancelled"},description:{$literal:"Total number of Cancelled Requests"}
            ,color:{$literal:colors.cancel},value:"$cancelled"}}
        ]

      ]
    else []

CommonHelpers.getUserStatisticsQuery=(userId)->
  if userId
    [
      [
        {$match:{'owner':userId}}
        {$group:{_id:null,timeliness:{$sum:"$timeliness"},performance:{$sum:"$performance"}
          ,accuracy:{$sum:"$accuracy"},delivery:{$sum:"$delivery"},average:{$sum:"$average"}}}
      ]
    ]
  else
    []

CommonHelpers.getFilterForScheduleExtended=(value,field)->
  unless field
    CommonHelpers.getFiltersForSchedule(value)
  else
    CommonHelpers.buildFilterQry([{field:field,value:value?.split(',') or [],operator:'$in'}])

