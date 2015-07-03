Template.registerHelper 'formatStatus',(status)->
  switch status
    when STATE_UNMATCHED then 'label-default'
    when STATE_MATCHED then 'label-warning'
    when STATE_BOOKED then 'label-info'
    when STATE_DISPATCH then 'label-success'
    when STATE_CANCELLED then 'label-default'
    when STATE_LATE  then  'label-inverse'
    when STATE_ISSUE  then  'label-danger'
    when STATE_SUCCESS  then  'label-primary'


Template.registerHelper 'formatUserState',(state)->
  if state then 'label-primary' else 'label-default'


Template.registerHelper 'accountTypes',->
  {shipper:'Shipper',trucker:'Trucker' }

Template.registerHelper 'alertMsg',(alert)->
  alertId=alert.id.substring(1,8)
  parentId=alert?.parent.substring(1,8)
  switch alert.type
    when NotifyTag.newRequest then 'a new request ##{alertId} has been made'
    when NotifyTag.updateRequest then 'changes made to request ##{alertId}'
    when NotifyTag.newBid then "#{alert.count} new bids on request ##{parentId}"
    when NotifyTag.updateBid then "#{alert.count} bid update(s) on request ##{parentId}"



