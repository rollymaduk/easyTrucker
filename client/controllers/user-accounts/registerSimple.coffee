AutoForm.hooks
  registerSimpleForm:
    onSubmit:(ins,upd,curr)->
      that=@
      res=$('#checkbox-accept-terms').is(":checked")
      unless res
        @done()
        swal 'Missing something there!','you have to accept our terms & conditions','warning'
      else
        [firstname,lastname]=(ins.fullName).split(" ")
        settings=Schema.userSettings.clean({})
        user={settings:settings,email:ins.email,profile:{firstname:firstname,lastname:lastname,emails:[ins.email],referredBy:ins.referredBy}}
        role=ins.accountType
        Eztrucker.Utils.Registration.registerNewUser(user,role,ins.email,Session.get('registerSubs'),(err,res)->
          if res then Router.go 'registrationSuccess' else console.log err
          that.done()
        )
      false
