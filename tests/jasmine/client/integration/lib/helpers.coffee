@mockAUser=(username)->
  username=username or 'gupklas'
  {username:username,password:'enterme1234',email:"#{username}@gmail.com"}
@mockAProfile=(name)->
  name=name or 'Robledo'
  {name:name,telephones:['08032006618'],emails:["#{name}@gmail.com"]}

