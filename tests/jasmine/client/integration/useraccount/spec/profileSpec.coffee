describe 'Update',()->
  describe 'a user profile',()->
    user= mockAUser('backenrosa')
    profile=mockAProfile('Ronald')
    role='shipper'
    beforeEach (done)->
      Meteor.call 'registerNewUser',user,role,(err,res)->
        throw new Meteor.Error err if err
        Meteor.loginWithPassword user.username,user.password,(err)->
          if err then throw new Meteor.Error err
          done()
          null
        null
      null


    afterEach (done)->
      Meteor.users.remove Meteor.userId(),(err,res)->
        Meteor.logout ()->
          done()
          null
        null
      null

    it 'should update profile',(done)->
      console.log profile
      Meteor.call 'updateUserProfile',Meteor.userId(),profile,(err,res)->
        console.log err
        expect(res).toEqual(1)
        expect(Meteor.user().profile).toEqual(profile)
        done()
        null
      null
    null
  null




describe 'Navigation',()->
  describe 'to profile page',()->
    describe 'user profile is empty',()->
      beforeEach (done)->
        spyOn(Meteor,'user').and.returnValue {profile:{}}
        spyOn(Meteor,'userId').and.returnValue 1
        Router.go 'profile'
        Tracker.afterFlush(done)
        null

      beforeEach(waitForRouter)

      it 'should redirect to profile entry form',(done)->
        expect($('.manageProfile').length).toBeGreaterThan(0)
        done()
        null
      null
    null
  null



xdescribe 'Navigation',()->
  describe 'to any page',()->
    describe 'user profile is empty',()->
      beforeEach (done)->
        spyOn(Meteor,'user').and.returnValue {}
        spyOn(Meteor,'userId').and.returnValue "userId"
        Router.go 'home'
        Tracker.afterFlush(done)
        null

      beforeEach(waitForRouter)

      it 'should have a profile update warning displayed',(done)->
        expect($('#profile_warning').length).toBeGreaterThan(0)
        done()
        null
      null
    null
  null



