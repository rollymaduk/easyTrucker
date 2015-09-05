Meteor.publish('userList',(domainroles)->
  ###todo fix security hole here remove domainroles parameter###
  roles=domainroles?.roles
  group=domainroles?.group
  if roles and group
    Roles.getUsersInRole(roles,group)
  else
    @ready()
)

Meteor.publishRelations('userInfo',(id,withImage)->
  if @userId
    withImage=withImage or false
    check(id,String)
    @cursor  Meteor.users.find(id,fields:profile:1),(docId,doc)->
      photo=Meteor._get(doc,'profile','photo')
      console.log photo
      if withImage and photo then @cursor eZImages.find(photo)
      null
  @ready()
)
