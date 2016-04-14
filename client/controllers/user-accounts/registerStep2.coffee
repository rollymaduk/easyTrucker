Template.registerStep2.created=->
  @isCompany=new ReactiveVar(false)
  @hasAuth=new ReactiveVar(false)


Template.registerStep2.destroyed=->
  @truckAuthSub.stop()

Template.registerStep2.helpers
  isTrucker:-> Meteor?.user()?.isTrucker()

  isCompany:-> Template.instance().isCompany.get()

  hasAuth:->Template.instance().hasAuth.get()

  truckAuthList:->TruckAuthorizations.find().map (doc)->
    label:doc.name,value:doc.name



Template.registerStep2.events
  'change [data-schema-key="accountType"]':(evt,temp)->
    console.log evt.target.value
    if evt.target.value is ACCOUNT_GROUP then temp.isCompany.set(true) else temp.isCompany.set(false)

  'change [data-schema-key="truckAuthorityType"]':(evt,temp)->
    console.log evt.target.value
    if evt.target.value is TEXT_NONE then temp.hasAuth.set(false) else temp.hasAuth.set(true)

Template.registerStep2.rendered=->
  AutoForm.resetForm("registerStep2")
  @isCompany.set(false)
  @hasAuth.set(false)
  @truckAuthSub=ddpTruckSearch?.subscribe('truckAuthorizations')

AutoForm.hooks
  registerStep2:
    onSubmit:(ins,upd,curr)->
      profile=Meteor.user().profile
      profile=_.extend(profile,ins)
      Meteor.call "updateUserProfile",Meteor.userId(),profile,(err,res)=>
        if res
          Session.set('registerComplete',false)
          Modal.hide()
        @done()
      false
  ,true

AutoForm.debug()

