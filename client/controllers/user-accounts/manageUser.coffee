Template.manageUser.helpers
  userAccountTypes:->
    roles=CommonHelpers.getRoles()
    if _.contains(roles,'shipper') then CommonHelpers.getAllRoles('shipper')
    else  CommonHelpers.getAllRoles('trucker')


AutoForm.hooks
  internalRegForm:onSubmit:(insertDoc,updDoc,currDoc)->
    service=new UserAccountService()
    console.log 'internalReg called!'
    userProfile=Meteor?.user()?.profile
    profile= _.extend(_.pick(userProfile,'companyName','companyAddress','truckAuthorityType','truckAuthorityNumber'
      ,'telephones'),_.pick(insertDoc,'firstname','lastname'),{emails:[insertDoc.email]}) if userProfile

    username=CommonHelpers.generateUsername(insertDoc.email,profile.companyName)

    password=CommonHelpers.generatePassword()

    user={username:username,email:insertDoc.email,password:password,profile:profile}

    role=insertDoc.accountType

    groupName=Meteor.user().username

    that=@

    service.registerNewUser user,role,groupName,(err,res)->
      if res
        Router.go 'userList'
        that.done()
      else
        swal 'Failure',err.message,'error'
        that.done()
    false

AutoForm.debug()
