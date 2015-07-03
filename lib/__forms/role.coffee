Form.Role=new SimpleSchema
  roles:
    type:[String]
    autoform:
      type: "universe-select",
      afFieldInput:
        multiple: true
        options:->
          if Meteor.isClient
            CommonHelpers.getAllRoles(Session.get('userType'))

