showResults=(resp,stat)->
  origins=resp.originAddresses
  if (status != google.maps.DistanceMatrixStatus.OK)
    swal('Error','An error occurred with availability service','error')
  else
    row.elements[0].duration.value for row in (resp.rows)


calculateDistance=(params...)->
  origins=params[0]
  destination=params[1]
  service = new google.maps.DistanceMatrixService();
  service.getDistanceMatrix(
    {
      origins: origins,
      destinations: destination,
      travelMode: google.maps.TravelMode.DRIVING,
      unitSystem: google.maps.UnitSystem.METRIC,
      avoidHighways: false,
      avoidTolls: false
    }, showResults)