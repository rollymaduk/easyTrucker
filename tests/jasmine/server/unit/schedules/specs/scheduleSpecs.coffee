describe 'scheduleItem',()->
  service=new TransactionService()
  describe 'with an update of existing schedule',()->
    schedule={_id:'upd_id',truckers:['vendor'],owner:'owner'}
    beforeEach (done)->
      spyOn(Schedules,'update').and.returnValue(1)
      spyOn(Activities,'insert')
      service.addUpdateSchedule(schedule)
      done()
      null

    it 'should create a new update notification for audience ',(done)->
      expect(Activities.insert).toHaveBeenCalled()
      expect(Activities.insert).toHaveBeenCalledWith({audience:schedule.truckers
        ,message:NotifyMessage.updateRequest,route:{name:'viewSchedule',param:{_id:schedule._id}},tag:'schedule'})
      done()
      null
    null

  describe 'with new insertion',()->
    schedule={truckers:['vendor'],owner:'owner'}
    beforeEach (done)->
      spyOn(Schedules,'insert').and.returnValue('schdl_id')
      spyOn(Activities,'insert')
      service.addUpdateSchedule(schedule)
      done()
      null

    it 'should create a new notification for audience',(done)->
      expect(Activities.insert).toHaveBeenCalled()
      expect(Activities.insert).toHaveBeenCalledWith({audience:schedule.truckers
        ,message:NotifyMessage.newRequest,route:{name:'viewSchedule',param:{_id:'schdl_id'}},tag:'schedule'})
      done()
      null
    null
  null



describe 'scheduleList',()->
  describe 'for shippers',()->
    server=userId:'userId'
    service=new QueryFilterService(server)
    query=null
    beforeEach (done)->
      spyOn(Meteor.users,'findOne').and.returnValue({})
      spyOn(Roles,'getRolesForUser').and.returnValue(['shipper'])
      query=filter:{owner:'userId'},modifier:sort:{createdAt:-1}
      done()
      null

    it 'should only filter schedules by logged in user',(done)->
      expect(service.scheduleListByRoles()).toEqual(query)
      done()
      null
    null
  null

describe 'scheduleList',()->
  describe 'for truckers',()->
    server=userId:'userId'
    service=new QueryFilterService(server)
    query=null
    beforeEach (done)->
      spyOn(Meteor.users,'findOne').and.returnValue({})
      spyOn(Roles,'getRolesForUser').and.returnValue(['trucker'])
      query=filter:{truckers:{$in:['userId']}},modifier:sort:{createdAt:-1}
      done()
      null

    it 'should only filter matched schedules',(done)->
      expect(service.scheduleListByRoles()).toEqual(query)
      done()
      null
    null
  null








