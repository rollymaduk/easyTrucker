Meteor.publish 'contactList',(user,limit)->
  limit=limit||50
  Contacts.find {},{limit:limit}
