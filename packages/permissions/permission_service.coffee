class PermService
  constructor:->
    @currentPermissions=null
  subscribeHandle=null
  isActive=new ReactiveVar(false)
  _internalPerm=new ReactiveVar([])
  subscribe_to_perm=(roles,callback)->
    isActive.set(true)
    if subscribeHandle
      subscribeHandle.stop()
    subscribeHandle=Meteor.subscribe('r_polly_perm_publish',roles,()->
      callback.call @ if callback
      isActive.set(false)
      null
    )

  add_to_perm=(role,permission)->
    R_polly_permissions.upsert {permission:permission},{$addToSet:roles:role}

  isLoading:isActive.get()

  getPermissionsForRoles:(roles,callback)->
    filter=if _.isArray(roles) then roles:$in:roles else roles:roles
    if(Meteor.isClient)
      subscribe_to_perm(roles,()=>
        @currentPermissions=R_polly_permissions.find(filter).map (doc)->doc.permission
        _internalPerm.set(@currentPermissions)
        callback.call @,@currentPermissions if callback
      )
      null
    else
      R_polly_permissions.find(filter).map (doc)->doc.permission

  hasPermissions:(perm)->
    if Meteor.userId()
      perm=unless _.isArray(perm) then [perm] else perm
      if(Meteor.isClient)
        _.intersection(_internalPerm.get(),perm).length>0
      else
        R_polly_permissions.find({permissions:$in:perm}).count()>0

  setCurrentRole:(role)->
    @getPermissionsForRoles(role)

  createPermissions:(permObj...)->
    if(Meteor.isServer and permObj.length>1)
      role=permObj[0]
      perm=permObj[1]
      if _.isArray(perm)
       permissions=(add_to_perm(role,item) for item in perm)
       permissions.length
      else add_to_perm(role,perm)

  removePermissions:(permArgs...)->
    if(Meteor.isServer)
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
    Tracker.autorun(->
      roles=Meteor?.user()?.roles
      roles=_.values(roles)[0] if roles
      RP_permissions.getPermissionsForRoles(roles)
    )

    Template.registerHelper('Rp_allow',(perm,show)->
      getPermissionVisibility(perm,false,show)
    )

    Template.registerHelper('Rp_deny',(perm,show)->
      getPermissionVisibility(perm,true,show)
    )

