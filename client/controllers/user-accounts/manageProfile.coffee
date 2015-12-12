AutoForm.hooks
  profileForm:
    onSubmit:(insertDoc,updateDoc,currDoc)->
      console.log insertDoc
      console.log Meteor.userId()
      Meteor.call('updateUserProfile',Meteor.userId(),insertDoc,(err,res)=>
        throw new Meteor.Error err if err
        Router.go 'account',Meteor.user()
        @done()
        null
      )
      false
