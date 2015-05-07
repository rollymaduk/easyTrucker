describe 'ScheduleList',()->
  describe 'for trucker',()->
    beforeEach (done)->
      spyOn(Meteor,'user').and.returnValue(roles:{global_grp:['trucker']})
      spyOn(Meteor,'userId').and.returnValue('user_id')
      Router.go 'scheduleList'
      Tracker.afterFlush(done)

    beforeEach(waitForRouter)

    it 'should not display create new schedule button',(done)->
      expect($('a[href="/schedules/new"]').length).toEqual(0)
      done()

  describe 'scheduleListItem for shipper',()->
    beforeEach (done)->
      spyOn(Meteor,'user').and.returnValue(roles:{global_grp:['shipper']})
      spyOn(Meteor,'userId').and.returnValue('user_id')
      Router.go 'scheduleList'
      Tracker.afterFlush(done)

    beforeEach(waitForRouter)

    it 'should not display place bid button',(done)->
      expect($(".place-bid").length).toEqual(0)
      done()
