Dispatches.after.insert (user,doc)->
  qry=_id:doc.schedule
  modifier=$set:{status:STATE_DISPATCH,nextStep:STATE_SUCCESS}
  Meteor.call "updateSchedule",qry,modifier,(err,res)->
    if res then Router.go 'filteredSchedules',{status:STATE_DISPATCH}
    else console.log err


