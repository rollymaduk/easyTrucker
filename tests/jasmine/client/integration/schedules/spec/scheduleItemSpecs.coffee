describe 'scheduleItem',()->
  describe 'for trucker',()->
    describe 'with no bid',()->
      beforeEach (done)->
        spyOn(Meteor,'user').and.returnValue {roles:global_grp:['trucker']}
        spyOn(Meteor, 'userId').and.returnValue 'userid'
        spyOn(Schedules,'find').and.returnValue [{_id:'item-schedule',bid:undefined}]
        Router.go 'scheduleList'
        Tracker.afterFlush(done)
        null

      beforeEach(waitForRouter)

      afterEach (done)->
        Router.go 'home'
        Tracker.afterFlush(done)

      afterEach(waitForRouter)

      it 'should display place bid button',(done)->
        expect($('.manage-bid').length).toBeGreaterThan(0)
        done()
        null
      null
    null
  null

xdescribe 'scheduleItem navigation',()->
  describe 'for shipper to schedule detail page',()->
    beforeEach (done)->
      schedule={_id:'item-schedule',bid:{}}
      spyOn(Meteor,'user').and.returnValue {roles:global_grp:['shipper']}
      spyOn(Meteor, 'userId').and.returnValue 'userid'
      spyOn(Bids,'find').and.returnValue [{}]
      Router.go 'viewSchedule',schedule
      Tracker.afterFlush(done)
      null

    beforeEach(waitForRouter)

    describe 'with no accepted bid',()->
      it 'should redirect to bid list page',(done)->
        expect($('.bidList').length).toBeGreaterThan(0)
        done()
        null
      null
    null
  null



xdescribe 'scheduleItem',()->
  describe 'for trucker',()->
    beforeEach (done)->
      spyOn(Meteor,'user').and.returnValue {roles:global_grp:['trucker']}
      spyOn(Meteor, 'userId').and.returnValue 'userid'
      spyOn(Schedules,'find').and.returnValue [{_id:'item-schedule',bid:{}}]
      Router.go 'scheduleList'
      Tracker.afterFlush(done)
      null

    beforeEach(waitForRouter)

    describe 'with  bid',()->
      it 'should not display place bid button',(done)->
        expect($('.manage-bid').length).toBe(0)
        done()
        null
      null
    null
  null
