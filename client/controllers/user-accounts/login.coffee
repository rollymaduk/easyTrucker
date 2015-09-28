AutoForm.hooks loginForm:onSubmit:(insert,update,current)->
  Meteor.loginWithPassword(insert.username,insert.password,(err)->
    if err
      sAlert.error(err.message,{})
      loginSchemaContext.addInvalidKeys [{name:'username',type:'UserNotExists'}]
      false
    else
      Router.go 'home'
  )
  @done()
  false
,true
