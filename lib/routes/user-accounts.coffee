Router.map ()->



Router.plugin('ensureSignedIn', {
  except: ['register','registrationSuccess','page','atForgotPwd','atSignUp']

});

AccountsTemplates.configureRoute('forgotPwd',{
  layoutTemplate: 'account_layout'
  template:'forgot_pass'
})

AccountsTemplates.configureRoute('signUp',{
  layoutTemplate: 'account_layout'
  template:'register'
  path:'/user/register'
})

AccountsTemplates.configureRoute('signIn',
  path:'/user/login'
  layoutTemplate:'account_layout'
  template:'login'
)

AccountsTemplates.configureRoute('ensureSignedIn',{
  template:'login'
  layoutTemplate: 'account_layout'
})

AccountsTemplates.configureRoute('changePwd',{
  layoutTemplate: 'main'
})