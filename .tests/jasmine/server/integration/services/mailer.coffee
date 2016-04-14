xdescribe 'mailer/services/send',()->
  beforeEach (done)->
    spyOn(HTTP,'post')
    Meteor.call 'fixture/getEmailObjects',3,(err,res)=>
     @emails=res if res
     done()
     null
    null


  it 'throws an error when wrong arguments are inserted',(done)->
    expect(()->Eztrucker.Services.Mailer.send({})).toThrow()
    done()
    null

  it 'sends mail with correct parameters',(done)->
    Eztrucker.Services.Mailer.send(@emails)
    data_obj=({path:"/api/v1/send",method:"POST",body:email} for email in @emails)
    expect(HTTP.post).toHaveBeenCalledWith("#{Meteor.settings.private.SWU_URL}/batch",{data:data_obj,auth:Meteor.settings.private.SWU_AUTH})
    done()
    null
  null




