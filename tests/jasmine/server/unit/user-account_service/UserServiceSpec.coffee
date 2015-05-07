describe 'Registration',()->
  describe 'Newly Registered User',()->
    userId='usrId'
    username="gupklas"
    beforeEach ()->
      spyOn(Accounts,'createUser').and.returnValue userId
      spyOn Accounts,'sendVerificationEmail'
      user={username:username,password:'enterme1234',email:'gupklas@gmail.com'}
      service=new UserAccountService()
      service.registerUser(user,'shipper')
      null

    it('should receive a verification email',()->
      expect(Accounts.sendVerificationEmail.calls.count()).toEqual(1)
      expect(Accounts.sendVerificationEmail).toHaveBeenCalledWith(userId)
    )
    null
  null