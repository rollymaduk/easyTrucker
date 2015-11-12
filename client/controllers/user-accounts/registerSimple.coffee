AutoForm.hooks
  registerSimpleForm:
    onSubmit:(ins,upd,curr)->
      [firstname,lastname]=(ins.fullName).split(" ")
      user={email:ins.email,profile:{firstname:firstname,lastname:lastname}}
      role=ins.accountType
      Eztrucker.Utils.Registration.registerNewUser(user,role,null,Session.get('registerSubs'),(err,res)=>
        @done()
        if res then Router.go 'registrationSuccess' else console.log err
      )
      false