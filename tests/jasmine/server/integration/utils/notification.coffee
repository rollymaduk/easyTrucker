describe 'notification/utility/getRequestNotificationItems',()->
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



describe 'notification/utility/getBidNotificationItems',()->
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

describe 'notification/utility/getRequestNotificationRecipients',()->
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
