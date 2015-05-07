describe 'Bid item',()->
  service=new TransactionService()

  describe 'with a new bid added',()->
    bid={owner:'owner',schedule:'schedule_id'}
    beforeEach (done)->
      spyOn(Bids,'insert').and.returnValue('insert_id')
      spyOn(Activities,'insert')
      spyOn(Schedules,'findOne').and.returnValue({owner:'userId'})
      service.addUpdateBids(bid)
      done()
      null
    it 'should create a new bid notification for audience',(done)->
      expect(Activities.insert).toHaveBeenCalled()
      expect(Activities.insert).toHaveBeenCalledWith({audience:['userId']
        ,message:NotifyMessage.newBid,route:{name:'viewBid',param:{_id:'insert_id'}},tag:'bid'})
      done()


  describe 'with existing bid updated',()->
    bid={owner:'owner',_id:'upd_id',schedule:'schedule_id'}
    beforeEach (done)->
      spyOn(Bids,'update').and.returnValue(1)
      spyOn(Activities,'insert')
      spyOn(Schedules,'findOne').and.returnValue({owner:'userId'})
      service.addUpdateBids(bid)
      done()
      null
    it 'should create an update bid notification for audience',(done)->
      expect(Activities.insert).toHaveBeenCalled()
      expect(Activities.insert).toHaveBeenCalledWith({audience:['userId']
        ,message:NotifyMessage.updateBid,route:{name:'viewBid',param:{_id:bid._id}},tag:'bid'})
      null
      done()




