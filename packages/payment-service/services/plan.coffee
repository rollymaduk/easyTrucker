Meteor.methods
  'plan/add':(plan,query,isTrustedCode=false)->
    try
      unless @isSimulation
        query=query or @userId
        check(@userId,String) unless isTrustedCode
        Meteor.users.update query,{$set:{plan:plan}}
      else
        console.log "processing..."
    catch error
      throw new Error "There was a problem adding plan: #{error}"

  'plan/remove':(query,isTrustedCode)->
    try
      unless @isSimulation
        query=query or @ userId
        check(@userId,String) unless isTrustedCode
        Meteor.users.update query,{$unset:{plan:""}}
      else
        console.log "processing..."
    catch error
      throw new Error "There was a problem removing plan: #{error}"
  ###'plan/change':(modify={})->
    try
      unless @isSimulation
        check(@userId,String)
        Meteor.users.update @userId,$set:{plan:modify}
      else
        console.log "processing..."
    catch error
      throw new Error "There was a problem changing plan: #{error}"###


