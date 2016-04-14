
StripePlanCount={
  updateCount:(planName)->
    Meteor.call "updateStripePlanCount",planName,(err,res)->
      if err
        if Meteor.isServer then throw new Error ("AppPlans Problem updating app plan count")
        else console.log err
      else
        if Meteor.isServer then res else console.log res
  }
