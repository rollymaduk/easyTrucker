@Contacts=new Meteor.Collection 'contacts',transform:(doc)->
   doc.fullName=()->
    "#{this.firstName} #{this.lastName}"
   doc
Contacts.attachSchema Schema.Contact
Contacts.allow
  insert:(user,doc)->true
  update:(user,doc,fields,modifier)->true
  remove:(user,doc)->true