Template.manageSchedule.helpers
  onfinished:->
    (e)->
      data=@getAllData()
      Schedules.insert data,(err,res)->
        if res then console.log res

  steps:->
    [{
      title:"Pick up"
      id:"puf"
      template:Template.pickup
      data:{}
    },
      {
        title:"Drop Off"
        id:"dof"
        template:Template.dropOff
        data:{}
      },
      {
        title:"Memo"
        id:"mf"
        template:Template.memo
        data:{}
      }
    ]