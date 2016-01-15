generateChart=(items,role,index)->
  console.log items
  chartValues=[]
  chartColors=[]
  baseIndex=0
  switch role
    when ROLE_TRUCKER,ROLE_SHIPPER
      if index is 0
        chartItems=items.slice(1,3)
      else
        chartItems=_.rest(items,2)
        baseIndex=1
    when ROLE_DRIVER then chartItems=_.rest(items)


  if chartItems
    _.each(chartItems,(doc)->
      chartValues.push({value:((doc['value']/items[baseIndex].value)*100).toFixed(1),label:doc['title']})
      chartColors.push(doc['color'])
    )
    console.log chartValues
    {datasource:chartValues,type:"pie",delay:200,options:{colors:chartColors,formatter:(y)->"#{y}%"}}



Template.dashboard.created=->
  @doughnut=new ReactiveVar()
  @filters=new ReactiveVar()
  @numbers=new ReactiveVar()
  @autorun ()=>
    role=Session.get('currentRole')
    Meteor.call 'getAggregationResults','schedules',CommonHelpers.getDashboardMetricsQuery(role),(err,res)=>
      console.log res
      if res
        numbers=_.compact(_.flatten(res))
        @numbers.set(numbers)
        switch role
          when ROLE_TRUCKER,ROLE_SHIPPER then filters=[numbers[0],numbers[2]]
          when ROLE_DRIVER then filters=[numbers[0]]
        @filters.set(filters) if filters
        @doughnut.set(generateChart(numbers,role,0))



Template.dashboard.helpers
  numbers:()->
    Template.instance().numbers.get()

  doughnut:()->
    Template.instance().doughnut.get()

  filters:()->
    Template.instance().filters.get()


