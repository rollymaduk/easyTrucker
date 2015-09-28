Template.registerHelper 'photoPlaceHolder','/img/profile-shadow.png'
Template.registerHelper 'formatStatus',(status)->
  switch status
    when STATE_UNMATCHED then 'label-default'
    when STATE_MATCHED then 'label-warning'
    when STATE_BOOKED then 'label-purple'
    when STATE_ASSIGNED then 'label-info'
    when STATE_DISPATCH then 'label-success'
    when STATE_CANCELLED then 'label-default'
    when STATE_LATE  then  'label-danger'
    when STATE_ISSUE  then  'label-magenta'
    when STATE_SUCCESS  then  'label-primary'


Template.registerHelper 'formatElement',(status)->
  switch status
    when STATE_UNMATCHED then 'default-element'
    when STATE_MATCHED then 'warning-element'
    when STATE_BOOKED then 'purple-element'
    when STATE_ASSIGNED then 'info-element'
    when STATE_DISPATCH then 'success-element'
    when STATE_CANCELLED then 'default-element'
    when STATE_LATE  then  'danger-element'
    when STATE_ISSUE  then  'magenta-element'
    when STATE_SUCCESS  then  'primary-element'

Template.registerHelper 'summarizeText',(text,length)->
  text.trimToLength(length)

Template.registerHelper 'formatUserState',(state)->
  if state then 'label-primary' else 'label-default'


Template.registerHelper 'visibleWhen',(item,compare)->
  compare=compare.split(',') or []
  isEqual=if _.isArray(item) then _.intersection(item,compare).length>0 else _.contains(compare,item)
  if isEqual then null else class:'hidden'

Template.registerHelper 'accountTypes',->
  {shipper:'Shipper',trucker:'Trucker' }

Template.registerHelper 'identity',(user)->
  user.company() or user.fullname()

Template.registerHelper 'canEditProfile',(user)->
  user is Meteor.userId()

Template.registerHelper 'alertMsg',(alert)->
  alertId=alert.id.substring(1,8)
  parentId=alert?.parent.substring(1,8)
  switch alert.type
    when NotifyTag.newRequest then 'a new request ##{alertId} has been made'
    when NotifyTag.updateRequest then 'changes made to request ##{alertId}'
    when NotifyTag.newBid then "#{alert.count} new bids on request ##{parentId}"
    when NotifyTag.updateBid then "#{alert.count} bid update(s) on request ##{parentId}"



