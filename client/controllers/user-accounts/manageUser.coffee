Template.manageUser.helpers
  userAccountTypes:->
    role=Meteor.user().role()
    res=CommonHelpers.getAllRoles(role)
    res



AutoForm.hooks
  internalRegForm:onSubmit:(insertDoc,updDoc,currDoc)->
    console.log 'internalReg called!'
    userProfile=Meteor?.user()?.profile
    settings=Schema.userSettings.clean({})
    profile= _.extend(_.pick(userProfile,'companyName','accountType','companyAddress','truckAuthorityType','truckAuthorityNumber'
      ,'telephones'),_.pick(insertDoc,'firstname','lastname'),{emails:[insertDoc.email]},{settings:settings}) if userProfile

    ###username=CommonHelpers.generateUsername(insertDoc.email,profile.companyName)###

    ###password=CommonHelpers.generatePassword()###


    user=_.extend({email:insertDoc.email},{profile:profile})

    role=insertDoc.userType

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
