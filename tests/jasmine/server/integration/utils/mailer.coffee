xdescribe 'mailer/utility/buildMailObject',()->
  it 'returns valid mail object with correct parameters',(done)->
    res=Eztrucker.Utils.Mailer.buildMailObject(jasmine.any(String),jasmine.any(String),jasmine.any(Object))
    expect(res).toEqual({email_id:jasmine.any(String),recipient:{address:jasmine.any(String)}
    ,email_data:jasmine.any(Object)})
    done()
