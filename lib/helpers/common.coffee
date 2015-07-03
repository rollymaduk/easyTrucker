@CommonHelpers={}
CommonHelpers.getRoles=()->
  roles=Meteor?.user()?.roles
  if roles
    _.values(roles)[0]
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
  switch type
    when 'shipper' then {clerk:'Clerk',shipper:'Administrator'}
    when 'trucker' then {driver:'Driver',accountant:'Accountant',trucker:'Administrator'}
    else null


CommonHelpers.buildFilterQry=(filters)->
  query=filter:{}
  groups={}
  _.each(filters,(doc)->
    if doc.value and doc.field
      myOp={}
      if doc.operator then myOp[doc.operator]=doc.value else myOp=doc.value
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
  if STATE_BIDDED then @buildFilterQry([{field:'status',value:key}])
  else @buildFilterQry([{field:'totalBids',value:1,operator:'$gte'}])

