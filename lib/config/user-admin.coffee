kAdminConfig =
  name: 'Admin',
  roles:['admin']
  collections:
    "Meteor.users":
      verbose: "Users"
      templates:
        "crud": {name: 'kAccountsAdminFluid'}





@kAccountsAdminConfig = {
  tableColumns: [
    {label:'Username',name:'username'}
  ]
}

