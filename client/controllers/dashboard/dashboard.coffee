Template.dashboard.created=->
  @doughnut=new ReactiveVar()
  @numbers=new ReactiveVar()
  @autorun ()=>
    role=Session.get('currentRole')
    Meteor.call 'getAggregationResults','schedules',CommonHelpers.getDashboardMetricsQuery(role),(err,res)=>
      if res
        chartValues=[]
        chartColors=[]
        _.each(_.flatten(_.rest(res)),(doc)->
          if res[0][0]
            doc.ratio=((doc.value/res[0][0].value)*100).toFixed(1)
            chartValues.push({value:doc.ratio,label:doc.title})
            chartColors.push(doc.color)
          )
        numbers=_.compact(_.flatten(res))
        @numbers.set(numbers)
        @doughnut.set({datasource:chartValues,type:'pie',delay:200,options:{colors:chartColors,formatter:(y)->"#{y}%"}})





Template.dashboard.helpers
  numbers:()->
    Template.instance().numbers.get()

  doughnut:()->
    Template.instance().doughnut.get()


