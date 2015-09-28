Router.map ()->
  @route('page',
    path:Meteor.settings.public.pagePath
    where:'server'
    action:()->
      html = SSR.render('layout')
      @response.writeHead 200,'Content-Type':'text/html'
      @response.end html
  )
  null


Router.plugin('ensureSignedIn', {
  except: ['register','registrationSuccess','page','atForgotPwd','atSignUp']

});

AccountsTemplates.configureRoute('forgotPwd',{
  layoutTemplate: 'user_account'
  template:'forgot_pass'
})

AccountsTemplates.configureRoute('signUp',{
  layoutTemplate: 'user_account'
  template:'register'
})

AccountsTemplates.configureRoute('ensureSignedIn',{
  template:'login'
  layoutTemplate: 'user_account'
})

AccountsTemplates.configureRoute('changePwd',{
  layoutTemplate: 'main'
})