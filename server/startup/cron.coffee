SyncedCron.add
  name:"check for late requests and update flags"
  schedule:(parser)->
    parser.text('every 5 min')
  job:()->
    res=Meteor.call 'checkAndUpdateLateSchedules'
    console.log "#{res} items where updated" if res

SyncedCron.add
  name:"check and update truck expiry policy"
  schedule:(parser)->
    parser.text('every 5 min')
  job:()->
    res=Meteor.call 'checkAndUpdatePolicyValidity'
    console.log "#{res} truck policies where updated" if res


Meteor.startup ->
  SyncedCron.start()
  null