xdescribe 'client/registration/utility/registerNewUser',()->
  beforeEach (done)->
    MeteorStubs.install()
    spyOn(AppPlans,'set')
    spyOn(Meteor,'call')
    done()

  afterEach (done)->
    MeteorStubs.uninstall()
    done()

  it 'should correct to a free plan with invalid subscription',(done)->
    plan=null
    Eztrucker.Utils.Registration.registerNewUser({email:faker.internet.email},jasmine.any.String,plan)
    expect(AppPlans.set.calls.mostRecent().args[0]).toEqual(SUBSCRIBE_FREE)
    done()

  it 'should add user to plan and initiate stripe subscription when subscription is valid',(done)->
    plan=SUBSCRIBE_ANNUAL
    Eztrucker.Utils.Registration.registerNewUser({email:faker.internet.email},jasmine.any.String,plan)
    expect(AppPlans.set).toHaveBeenCalled()
    done()

  it 'register new user after successfully adding user to plan',(done)->
    plan=SUBSCRIBE_ANNUAL
    Eztrucker.Utils.Registration.registerNewUser({email:faker.internet.email},jasmine.any.String,plan)
    AppPlans.set.calls.mostRecent().args[2](new Meteor.Error(1111,"An Error"))
    expect(Meteor.call.calls.mostRecent().args[0]).toEqual('registerNewUser')
    done()