SyncedCron.add
  name:"check for late requests and update flags"
  schedule:(parser)->
    parser.text('every 5 min')
  job:()->
    res=Meteor.call 'checkAndUpdateLateSchedules'
    console.log "#{res} items where updated" if res


Meteor.startup ->
  SyncedCron.start()
  null