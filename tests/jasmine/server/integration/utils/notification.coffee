describe 'notification/utility/getRequestReminderMessage',()->
  beforeEach (done)->
    Meteor.call 'fixture/getSchedule',(err,res)=>
      if res then @doc=_.omit(res,'_id') else console.log err
      done()
  it 'should return valid reminder message item for nextStep expire request',(done)->
    @doc.nextStep=STATE_EXPIRE
    res=Eztrucker.Utils.Notification.getRequestReminderMessage(@doc,"2015-09-26T16:12:00.000Z")
    expect(res.title).toEqual("#{@doc.wayBill} - Expires in 2 days")
    expect(res.description).toEqual("#{@doc.wayBill} - #{@doc.shipmentTitle} expires in 2 days")
    done()
  it 'should return valid reminder message item for nextStep dispatch request',(done)->
    @doc.nextStep=STATE_DISPATCH
    res=Eztrucker.Utils.Notification.getRequestReminderMessage(@doc,"2015-09-26T16:12:00.000Z")
    expect(res.title).toEqual("#{@doc.wayBill} - Dispatches in 2 days")
    expect(res.description).toEqual("#{@doc.wayBill} - #{@doc.shipmentTitle} will dispatch in 2 days")
    done()
  it 'should return valid reminder message item for nextStep delivery request',(done)->
    @doc.nextStep=STATE_SUCCESS
    res=Eztrucker.Utils.Notification.getRequestReminderMessage(@doc,"2015-09-26T16:12:00.000Z")
    expect(res.title).toEqual("#{@doc.wayBill} - Delivers in 2 days")
    expect(res.description).toEqual("#{@doc.wayBill} - #{@doc.shipmentTitle} will deliver in 2 days")
    done()

describe 'notification/utility/getRequestReminderAudience',()->
  beforeEach (done)->
    Meteor.call 'fixture/getSchedule',(err,res)=>
      if res then @doc=_.omit(res,'_id') else console.log err
      done()
  it 'should return shipper and matched truckers  for nextStep expire request',(done)->
    @doc.nextStep=STATE_EXPIRE
    res=Eztrucker.Utils.Notification.getRequestReminderAudience(@doc)
    expect(res,_.union(@doc.truckers.owner,@doc.owner))
    done()
  it 'should return winningBidder,shipper and driver for nextStep dispatch request',(done)->
    @doc.nextStep=STATE_DISPATCH
    res=Eztrucker.Utils.Notification.getRequestReminderAudience(@doc)
    expect(res,[@doc.winningBid.bidder,@doc.owner,@doc.resource.driver])
    done()
  it 'should return winningBidder and shipper for nextStep delivery request',(done)->
    @doc.nextStep=STATE_SUCCESS
    res=Eztrucker.Utils.Notification.getRequestReminderAudience(@doc)
    expect(res,[@doc.winningBid.bidder,@doc.owner])
    done()

describe 'schedules/Utils/getBaselineDate',()->
  beforeEach (done)->
    Meteor.call 'fixture/getBid',(err,res)=>
      if res then @doc=_.omit(res,'_id') else console.log err
      done()

  it 'should return pickupDate for Request with nextStep in Expire state',(done)->
    res=Eztrucker.Utils.Notification.getBaselineDate(STATE_EXPIRE,@doc)
    expect(res).toEqual(@doc.schedule.pickupDate.dateField_1)
    done()

  it 'should return pickupDate for Request with nextStep in Dispatch state',(done)->
    res=Eztrucker.Utils.Notification.getBaselineDate(STATE_DISPATCH,@doc)
    expect(res).toEqual(@doc.schedule.pickupDate.dateField_1)
    done()



  it 'should return dropoffDate for Request with nextStep in Success state',(done)->
    res=Eztrucker.Utils.Notification.getBaselineDate(STATE_SUCCESS,@doc)
    expect(res).toEqual(@doc.schedule.dropOffDate.dateField_1)
    done()


describe 'schedules/Utils/filterUserByReminderSettings',()->
  beforeEach (done)->
     @users=[
          {emails:[address:"email_1@mail.com"],settings:{reminder:[STATE_EXPIRE,STATE_SUCCESS,STATE_DISPATCH],reminderPeriod:1}}
          {emails:[address:"email_2@mail.com"],settings:{reminder:[],reminderPeriod:1}}
        ]
     done()

  it 'should only return user with valid reminder',(done)->
     res=Eztrucker.Utils.Notification.filterUsersByReminderSettings(@users,"2015-09-26T16:12:00.000Z"
     ,"2015-09-25T16:12:00.000Z")
     expect(res).toEqual(["email_1@mail.com"])
     done()

  it 'should not allow reminders for reminder periods less than 1 day',(done)->
    userNoReminder=_.clone(@users)
    userNoReminder[0].settings.reminderPeriod=0
    res=Eztrucker.Utils.Notification.filterUsersByReminderSettings(userNoReminder,"2015-09-26T16:12:00.000Z",
      "2015-09-25T16:12:00.000Z")
    expect(res).toEqual([])
    done()

  it 'should not allow reminders for reminder not within valid period ',(done)->
    users=_.clone(@users)
    users[1].settings={reminder:[STATE_EXPIRE],reminderPeriod:2}
    res=Eztrucker.Utils.Notification.filterUsersByReminderSettings(users,"2015-09-26T16:12:00.000Z"
    ,"2015-09-24T16:12:00.000Z")
    expect(res).toEqual(["email_2@mail.com"])
    done()

xdescribe 'notification/utility/getRequestNotificationItems',()->
  beforeEach (done)->
    Meteor.call 'fixture/getSchedule',(err,res)=>
      if res then @doc=_.omit(res,'_id') else console.log err
      done()

  it 'should throw error with invalid request doc',(done)->
    @doc.status="anotherStatus"
    expect(()=>Eztrucker.Utils.Notification.getRequestNotificationItems(@doc)).toThrow()
    done()

  it 'should return valid notification item for new request',(done)->
    @doc.status=STATE_NEW
    res=Eztrucker.Utils.Notification.getRequestNotificationItems(@doc,@doc.owner)
    expect(res.title).toEqual(TITLE_NEW)
    expect(res.description).toEqual("Shipment request for #{@doc.shipmentTitle}(#{@doc.wayBill})")
    expect(res.collection).toEqual(COLLECTION_REQUEST)
    done()

  it 'should return valid notification item for assigned request',(done)->
    @doc.status=STATE_ASSIGNED
    res=Eztrucker.Utils.Notification.getRequestNotificationItems(@doc)
    expect(res.title).toEqual(TITLE_NEW)
    expect(res.description).toEqual("Assignment for shipment Request: #{@doc.shipmentTitle}(#{@doc.wayBill})")
    expect(res.collection).toEqual(COLLECTION_REQUEST)
    done()

  it 'should return valid notification item for accepted request',(done)->
    @doc.status=STATE_BOOKED
    res=Eztrucker.Utils.Notification.getRequestNotificationItems(@doc)
    expect(res.title).toEqual(TITLE_UPDATE)
    expect(res.description).toEqual("You won a bid for shipment Request: #{@doc.shipmentTitle}(#{@doc.wayBill})")
    expect(res.collection).toEqual(COLLECTION_REQUEST)
    done()

  it 'should return valid notification for pre and  post assignment request',(done)->
    @doc.status=STATE_DISPATCH
    res=Eztrucker.Utils.Notification.getRequestNotificationItems(@doc)
    expect(res.title).toEqual(TITLE_UPDATE)
    expect(res.description).toEqual("Shipment status changed to #{@doc.status} for Request: #{@doc.shipmentTitle}(#{@doc.wayBill})")
    expect(res.collection).toEqual(COLLECTION_REQUEST)
    done()



xdescribe 'notification/utility/getBidNotificationItems',()->
  beforeEach (done)->
    Meteor.call 'fixture/getBid',(err,res)=>
      if res then @doc=_.omit(res,'_id') else console.log err
      done()
  it 'should throw error with invalid bid doc',(done)->
    @doc.schedule=null
    expect(()=>Eztrucker.Utils.Notification.getBidNotificationItems(@doc)).toThrow()
    done()
  it 'should return valid notification for new bid',(done)->
    res=Eztrucker.Utils.Notification.getBidNotificationItems(@doc,true)
    expect(res.title).toEqual(TITLE_NEW)
    expect(res.description).toEqual("Bid for #{@doc.schedule.shipmentTitle}")
    expect(res.collection).toEqual(COLLECTION_BID)
    done()

  it 'should return valid notification for existing bid',(done)->
    res=Eztrucker.Utils.Notification.getBidNotificationItems(@doc)
    expect(res.title).toEqual(TITLE_UPDATE)
    expect(res.description).toEqual("Bid changed for #{@doc.schedule.shipmentTitle}")
    expect(res.collection).toEqual(COLLECTION_BID)
    done()

xdescribe 'notification/utility/getRequestNotificationRecipients',()->
  beforeEach (done)->
    Meteor.call 'fixture/getSchedule',(err,res)=>
      if res then @doc=_.omit(res,'_id') else console.log err
      done()
  it 'should throw error with invalid request',(done)->
    @doc.status='anotherStatus'
    expect(()=>Eztrucker.Utils.Notification.getRequestNotificationRecipients(@doc,@doc.owner)).toThrow()
    done()

  it 'should return matched truckers for new requests',(done)->
    @doc.status=STATE_NEW
    res=Eztrucker.Utils.Notification.getRequestNotificationRecipients(@doc,@doc.owner)
    expect(res).toEqual({audience:_.map(@doc.truckers,(doc)->doc.owner),sender:@doc.owner})
    done()

  it 'should return bid winner for accepted request',(done)->
    @doc.status=STATE_BOOKED
    res=Eztrucker.Utils.Notification.getRequestNotificationRecipients(@doc,@doc.owner)
    expect(res).toEqual({audience:[@doc.winningBid.bidder],sender:@doc.owner})
    done()

  it 'should return request owner and driver for assigned request',(done)->
    @doc.status=STATE_ASSIGNED
    res=Eztrucker.Utils.Notification.getRequestNotificationRecipients(@doc,@doc.winningBid.bidder)
    expect(res).toEqual({audience:[@doc.owner,@doc.resource.driver],sender:@doc.winningBid.bidder})
    done()

  it 'should return request owner and bidder for post bid request update by driver',(done)->
    @doc.status=STATE_DISPATCH
    res=Eztrucker.Utils.Notification.getRequestNotificationRecipients(@doc,@doc.resource.driver)
    expect(res).toEqual({audience:[@doc.winningBid.bidder,@doc.owner],sender:@doc.resource.driver})
    done()

  it 'should return request owner and driver for post bid request change by bidder',(done)->
    @doc.status=STATE_DISPATCH
    res=Eztrucker.Utils.Notification.getRequestNotificationRecipients(@doc,@doc.winningBid.bidder)
    expect(res).toEqual({audience:[@doc.resource.driver,@doc.owner],sender:@doc.winningBid.bidder})
    done()
