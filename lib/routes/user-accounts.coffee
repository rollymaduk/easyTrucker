Router.map ()->



Router.plugin('ensureSignedIn', {
  except: ['registrationSuccess','page','atForgotPwd','atSignUp']

});

AccountsTemplates.configureRoute('forgotPwd',{
  layoutTemplate: 'blankLayout'
  template:'forgot_pass'
})

AccountsTemplates.configureRoute('signUp',{
  layoutTemplate: 'blankLayout'
  template:'registerSimple'
  path:'/user/register'
})

AccountsTemplates.configureRoute('signIn',
  path:'/user/login'
  layoutTemplate:'blankLayout'
  template:'login'
)

AccountsTemplates.configureRoute('ensureSignedIn',{
  template:'login'
  layoutTemplate: 'blankLayout'
})

AccountsTemplates.configureRoute('changePwd',{
  layoutTemplate: 'main'
})