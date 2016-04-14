class PermService
  constructor:->
    @currentPermissions=null
  isActive=new ReactiveVar(false)


  add_to_perm=(role,permission)->
    if R_polly_permissions.findOne {permission:permission}
      R_polly_permissions.update {permission:permission},{$addToSet:roles:role}
    else
      R_polly_permissions.insert {permission:permission,roles:[role]}

  isLoading:isActive.get()

  getPermissionsForRoles:(roles)->
    filter=if _.isArray(roles) then roles:$in:roles else roles:roles
    res=R_polly_permissions.find(filter).map (doc)->doc.permission
    res


  hasPermissions:(perm)->
    perm=unless _.isArray(perm) then [perm] else perm
    R_polly_permissions.find({permission:$in:perm}).count()>0



  createPermissions:(permObj...)->
    if Meteor.isServer
      console.log [permObj[0],permObj[1]]
      perm=if _.isArray(permObj[1]) then permObj[1] else [permObj[1]]
      permissions=(add_to_perm(permObj[0],item) for item in permObj[1])
      permissions.length


  removePermissions:(permArgs...)->
    if Meteor.isServer
      if permArgs.length>1
        role=permArgs[0]
        perm=permArgs[1]
        filter=if _.isArray(perm) then permission:$in:perm else permission:perm
        R_polly_permissions.update(filter,$pull:roles:role,multi:true)
      else
        perm=permArgs[0]
        filter=if _.isArray(perm) then permission:$in:perm else permission:perm
        R_polly_permissions.remove(filter)

RP_permissions=new PermService()

getPermissionVisibility=(perm,deny,show)->
  res=if show then null else class:'hidden'
  if perm
    arr=perm.split(',') or []
    switch
      when not deny
        res=if R_polly_permissions.find({permission:$in:arr}).count()>0 then null else  class:'hidden'
      else
        res=if R_polly_permissions.find({permission:$in:arr}).count()>0 then class:'hidden' else null
  res



if Meteor.isClient
  Meteor.startup ()->
    Meteor.subscribe('r_polly_perm_publish')


    Template.registerHelper('Rp_allow',(perm,show)->
      getPermissionVisibility(perm,false,show)
    )

    Template.registerHelper('Rp_deny',(perm,show)->
      getPermissionVisibility(perm,true,show)
    )

