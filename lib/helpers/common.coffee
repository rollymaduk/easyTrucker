@CommonHelpers={}
CommonHelpers.getRoles=()->
  roles=Meteor?.user()?.roles
  if roles
    res=_.values(roles)[0]
    console.log res
    res
  else []

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
  console.log type
  switch type
    when 'shipper' then {clerk:'Clerk',shipper:'Administrator'}
    when 'trucker' then {driver:'Driver',accountant:'Accountant',trucker:'Administrator'}
    else null

CommonHelpers.getNotificationAudience=(users,exlude)->
  users=if _.isArray(users) then users else []
  _.without(users,exlude)


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
  switch
    when _.isEqual(key,STATE_BIDDED) then @buildFilterQry([{field:'bidders',value:Meteor.userId()}
    ,{field:'status',value:STATE_NEW}])
    when _.isEqual(key,STATE_UNMATCHED) then @buildFilterQry([{field:'truckers',value:0,operator:'$size'}
    ,{field:'status',value:STATE_NEW}])
    when _.isEqual(key,STATE_MATCHED)
      if Meteor.user().isTrucker()
        @buildFilterQry([{field:'truckers.owner',value:[Meteor.userId()],operator:'$in'},{field:'status',value:STATE_NEW}])
      else
        @buildFilterQry([{field:'truckers.owner',value:true,operator:'$exists'},{field:'status',value:STATE_NEW}])
    when _.isEqual(key,STATE_BOOKED)
      if Meteor.user().isTrucker()
        @buildFilterQry([{field:'shipper',value:Meteor.userId()},{field:'status',value:STATE_BOOKED}])
      else
        @buildFilterQry([{field:'status',value:key}])
    else
      @buildFilterQry([{field:'status',value:key}])

CommonHelpers.getFiltersForTrucks=(key)->
  @buildFilterQry([{field:'_id',value:key?.split(",") or [],operator:'$in'}])


