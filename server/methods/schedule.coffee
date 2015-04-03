Meteor.methods
  addUpdateSchedule:(schedule)->
    result= Schedules.upsert(schedule._id,{$set:schedule})
    return result
  searchTrucks:(pipeline)->
    result=Trucks.aggregate(pipeline)
    return result