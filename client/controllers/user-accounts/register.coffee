Template.register.created=()->
  Session.set('truckAuthState','readonly')

toggleTruckAuthority=(type)->
  switch type
    when 'shipper' then 'readonly'
    else null


Template.register.events
  'change [data-schema-key="accountType"]':(evt,temp)->
    formtype=toggleTruckAuthority evt.target.value
    Session.set('truckAuthState',formtype)

Template.truckAuthority.helpers
  formType:()->
    Session.get('truckAuthState')

Template.truckAuthority.rendered=()->
  @autorun((c)->
    $('input[data-schema-key="truckAuthState"]').val(Session.get('truckAuthState'))
  )



Template.register.helpers
  onfinished:->
    (e)->
      data=@getAllData()

      service=new UserAccountService()

      {firstname,lastname,companyName,companyAddress,truckAuthorityType,truckAuthorityNumber}=data

      profile={firstname:firstname,lastname:lastname,companyAddress:companyAddress,
      truckAuthorityType:truckAuthorityType,truckAuthorityNumber:truckAuthorityNumber,companyName:companyName,
      emails:[data.email],telephones:[data.telephoneNumber]
      }
      username=CommonHelpers.generateUsername(data.email,profile.companyName)

      password=CommonHelpers.generatePassword()

      user={username:username,email:data.email,password:password,profile:profile}

      role=data.accountType

      service.registerNewUser user,role,null,(err,res)->
        if res
          Router.go 'registrationSuccess'
        else
          swal 'Failure',err.message,'error'



  oncanceled:->
    (e)->
      Router.go 'login'

  steps:->
    [{
      title:"Step 1"
      id:"regAcctDetailForm"
      template:Template.registerAccountDetail
      data:@data||{}
    },
      {
        title:"Step 2"
        id:"regInfoDetailForm"
        template:Template.registerInfoDetail
        data:@data||{}
      },
      {
        title:"Step 3"
        id:'regTruckAuthorityForm'
        template:Template.truckAuthority
        data:@data||{}
      }
    ]


###
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
###

