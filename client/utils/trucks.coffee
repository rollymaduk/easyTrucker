Eztrucker.Utils.Trucks={
  getTruckAvailability:(schedules,bid)->
    res=_.map(schedules,(schedule)->
      schdlRange=moment(schedule.pickupDate.dateField_1).twix(schedule.dropOffDate.dateField_1)
      bidRange=moment(bid.schedule.pickupDate.dateField_1).twix(bid.schedule.dropOffDate.dateField_1)
      if (schedule.pickupDate.dateField_2 and schedule.dropOffDate.dateField_2)
        range=moment(schedule.pickupDate.dateField_2).twix(schedule.dropOffDate.dateField_2)
        schdlRange=schdlRange.union(range)

      if bid.schedule.pickupDate.dateField_2 and bid.schedule.dropOffDate.dateField_2
        range=moment(bid.schedule.pickupDate.dateField_2).twix(bid.schedule.dropOffDate.dateField_2)
        bidRange=bidRange.union(range)
      console.log schdlRange
      console.log bidRange
      schdlRange.overlaps(bidRange)
    )
    _.compact(res)
}