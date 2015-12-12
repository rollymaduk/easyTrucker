Template.manageUser.helpers
  userAccountTypes:->
    role=Meteor.user().role()
    res=CommonHelpers.getAllRoles(role)
    debugger
    res



AutoForm.hooks
  internalRegForm:onSubmit:(insertDoc,updDoc,currDoc)->
    console.log 'internalReg called!'
    userProfile=Meteor?.user()?.profile
    profile= _.extend(_.pick(userProfile,'companyName','companyAddress','truckAuthorityType','truckAuthorityNumber'
      ,'telephones'),_.pick(insertDoc,'firstname','lastname'),{emails:[insertDoc.email]}) if userProfile

    ###username=CommonHelpers.generateUsername(insertDoc.email,profile.companyName)###

    ###password=CommonHelpers.generatePassword()###

    user={email:insertDoc.email,profile:profile}

    role=insertDoc.accountType

    groupName=Roles.getGroupsForUser(Meteor.userId())

    that=@

    Eztrucker.Utils.Registration.registerUser user,role,groupName[0],(err,res)->
      if res
        Router.go 'userList'
        that.done()
      else
        swal 'Failure',err.message,'error'
        that.done()
    false
  ,true

AutoForm.debug()
