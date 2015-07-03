Meteor.methods
  addTruck:(truck)->
    unless truck._id
      Trucks.insert truck
    else
      Trucks.update truck._id,{$set:truck}

  searchTrucks:(pipeline)->
    Trucks.aggregate(pipeline)

