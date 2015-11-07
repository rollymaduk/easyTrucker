Router.map ()->



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
  path:'/user/register'
  onBeforeAction:()->
    console.log 'here before we roll'
})

AccountsTemplates.configureRoute('signIn',
  path:'/user/login'
  layoutTemplate:'user_account'
  template:'login'
)

AccountsTemplates.configureRoute('ensureSignedIn',{
  template:'login'
  layoutTemplate: 'user_account'
})

AccountsTemplates.configureRoute('changePwd',{
  layoutTemplate: 'main'
})