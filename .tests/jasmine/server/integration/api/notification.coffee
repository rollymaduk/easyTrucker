xdescribe "notification/api/sendRequestNotification",()->
  beforeEach (done)->
    spyOn(Meteor.users,'findOne').and.returnValue({profile:companyName:faker.company.companyName})
    emails=(address:faker.internet.email() for email in [0,3])
    spyOn(Meteor.users,'find').and.returnValue([emails:emails])
    spyOn(Activities,'insert')
    spyOn(Eztrucker.Services.Mailer,'send')
    res=Meteor.call 'fixture/getSchedule'
    @doc=_.omit(res,'_id')
    Meteor.call 'sendRequestNotification',@doc,@doc.owner
    @notifyObj=Eztrucker.Utils.Notification.getRequestNotificationItems(@doc)
    done()

  it 'should add a new activity to activity stream',(done)->
    recipients=Eztrucker.Utils.Notification.getRequestNotificationRecipients(@doc,@doc.owner)
    expected={parent:@doc._id,title:@notifyObj.title,description:@notifyObj.description,documentId:@doc._id
      ,collectionName:@notifyObj.collectionName,audience:recipients.audience}
    expect(Activities.insert).toHaveBeenCalledWith(expected)
    done()

  it 'should send notification emails to recipients',(done)->
    expect(Eztrucker.Services.Mailer.send).toHaveBeenCalled()
    done()


