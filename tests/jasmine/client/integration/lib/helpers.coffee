@mockAUser=(username)->
  username=username or 'gupklas'
  {username:username,password:'enterme1234',email:"#{username}@gmail.com"}
@mockAProfile=(name)->
  name=name or 'Robledo'
  {firstname:name,lastname:'lastname',telephones:['08032006618']
    ,emails:["#{name}@gmail.com"],companyName:'companyName',companyAddress:'companyAddress'
    ,truckAuthorityType:'DOT',truckAuthorityNumber:'1234CO'}

