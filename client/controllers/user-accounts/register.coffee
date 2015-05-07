AutoForm.hooks
  registerForm:
    onSubmit:(insert,update,current)->
      user={username:insert.username,email:insert.email,password:insert.password,profile:{}}
      role=insert.accountType
      that=@
      service=new UserAccountService()
      service.registerNewUser user,role,(res)->
        that.done(null,res)
      false
    onSuccess:(ftype,res)->
      Router.go 'registrationSuccess'
      null
  ,true

