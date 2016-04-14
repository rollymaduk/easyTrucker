Meteor.methods
  'payment/add':(payment,isTrustedCode=false)->
    try
      unless @isSimulation
        check(@userId,String) unless  isTrustedCode
        check(payment,Object)
        pSUtility.Collections.Payments.insert payment
      else console.log "processing..."
    catch error
      throw new Error "There was a problem adding payment: #{error}"



