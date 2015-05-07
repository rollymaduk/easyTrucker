describe 'scheduleDetail',()->
  describe 'for trucker',()->
    describe 'with no bid',()->
      beforeEach (done)->
        scheduleDtl={_id:'schedule_Dtl_Id',bid:undefined}
        spyOn(Meteor,'user').and.returnValue({profile:{}})
        spyOn(Meteor,'userId').and.returnValue('userId')
        Router.go('viewSchedule',scheduleDtl)
        Tracker.afterFlush(done)
        null

      beforeEach(waitForRouter)

      it 'should display no bid warning',(done)->
        expect($("#schedule-detail").length).toBeGreaterThan(0)
        expect($('.place-bid').length).toBeGreaterThan(0)
        done()
        null
      null
    null
  null

