###@bigSubs=new SubsManager({cacheLimit: 9999, expireIn: 9999});###

Router.configure {layoutTemplate:'main'}

Router.map ()->
  @route('home',path:'/')

  @route('newSchedule'
  ,path:'/schedule/new'
  ,template:"manageSchedule")
  null