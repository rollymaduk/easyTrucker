describe 'Registration',()->
  describe 'register a new user externally',()->
    userId=undefined
    role='shippers'
    username="temondrasat"
    user=mockAUser(username)
    beforeAll (done)->
      Meteor.call 'registerNewUser',user,role,(err,res)->
        throw new Meteor.Error err if err
        userId=res
        Meteor.loginWithPassword(user.username,user.password,(err)->
          if err then throw new Meteor.Error err
          done()
          null
        )
        null
      null

    afterAll (done)->
      if Meteor.userId()
        Meteor.users.remove(Meteor.userId(),(err,res)->
          Meteor.logout(()->
            done()
            null
          )
          null
        )
        null


    it 'should create registered user',(done)->
      expect(userId).not.toBeNull()
      expect(userId).toEqual(Meteor.userId())
      done()
      null


    it 'should create and add user to a new role and group',(done)->
      userRoles=_.values(_.pick(Meteor.user().roles,username))
      expect(userRoles[0]).toEqual(['shippers','admin'])
      done()
      null
    null
  null
null

describe 'Navigation',()->
  describe 'after successful registration',()->
    beforeEach ()->
    it 'should go to the verify user page',()->

  describe 'after successful login',()->
    beforeEach (done)->
      spyOn(Meteor,'user').and.returnValue {profile:{}}
      spyOn(Meteor,'userId').and.returnValue 1
      Router.go 'home'
      Tracker.afterFlush(done)

    beforeEach(waitForRouter)

    it 'should go to the dashboard page',(done)->
      console.log $(".dashboard").length
      expect($(".dashboard").length).toBeGreaterThan(0)
      done()
      null
    null
  null
null
