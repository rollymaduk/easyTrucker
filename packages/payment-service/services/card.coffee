Meteor.methods
  'card/add':(card,isTrustedCode=false)->
    check(@userId) unless isTrustedCode
    pSUtility.Collections.Cards.insert card

  'card/remove':(id,isTrustedCode=false)->
    try
      unless @isSimulation
        check(id,String)
        check(@userId,String) unless isTrustedCode
        pSUtility.Collections.Cards.remove({id:id})
      else  console.log "processing..."
    catch error
      throw new Error "There was a problem removing card #{error.message}"

  'card/change':(id,modify={},isTrustedCode=false)->
    try
      unless @isSimulation
        check(id,String)
        check(@userId,String) unless isTrustedCode
        pSUtility.Collections.Cards.update({id:id},$set:modify)
      else  console.log "processing..."
    catch error
      throw new Error "There was a problem changing card #{error.message}"

