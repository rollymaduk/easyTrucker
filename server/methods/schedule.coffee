Meteor.methods
  addUpdateSchedule:(schedule)->
    service= new TransactionService()
    service.addUpdateSchedule(schedule)

  searchTrucks:(pipeline)->
    result=Trucks.aggregate(pipeline)
    return result