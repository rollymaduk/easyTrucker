###@bigSubs=new SubsManager({cacheLimit: 9999, expireIn: 9999});###

Router.map ()->
  @route('contactList',
  path:'/app/contactList'
  data:->Contacts.find()
  waitOn:->Meteor.subscribe('contactList',50))

  @route('addContact',
    path:'/app/contact/new'
    template:"manageContact"
    )

  null