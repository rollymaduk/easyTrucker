Template.register.created=->
  Session.set('truckAuthFormState',null)

toggleTruckAuthFormState=(type)->
  switch type
    when 'shipper' then Session.set('truckAuthFormState',false)
    else Session.set('truckAuthFormState',true)



Template.register.events
  'change [data-schema-key="accountType"]':(evt,temp)->
    toggleTruckAuthFormState(evt.target.value)


Template.registerInfoDetail.helpers
  hasTruckAuth:()->
    Session.get('truckAuthFormState')

Template.registerInfoDetail.rendered=()->
  @autorun((c)=>
    $('input[data-schema-key="truckAuthState"]').val(Session.get('truckAuthState'))
  )

Template.register.isValid=new ReactiveVar(false)

Template.register.helpers
  onfinished:->
    (e)->
      data=@getAllData()

      {firstname,lastname,companyName,companyAddress,truckAuthorityType,truckAuthorityNumber}=data

      profile={firstname:firstname,lastname:lastname,companyAddress:companyAddress,
      truckAuthorityType:truckAuthorityType,truckAuthorityNumber:truckAuthorityNumber,companyName:companyName,
      emails:[data.email],telephones:[data.telephoneNumber]
      }

      user={username:data.username,email:data.email,password:data.password,profile:profile}

      role=data.accountType

      Eztrucker.Utils.Registration.registerNewUser(user,role,null,Session.get('registerSubs'),(err,res)->
        if res then Router.go 'registrationSuccess' else console.log err
      )

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
        id:'regAccountLoginDetailForm'
        template:Template.registerAccountLoginDetail
        data:@data||{}
      },
      {
        title:"Step 3"
        id:"regInfoDetailForm"
        template:Template.registerInfoDetail
        data:@data||{}
        onValidate: ()->
          res=$('#checkbox-accept-terms').is(":checked")
          unless res then swal 'Missing something there!','you have to accept our terms & conditions','warning'
          console.log res
          res
      }
    ]

Template.body.events
  'click .showDisclaimer':()->
    Modal.show 'disclaimerModal'

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

