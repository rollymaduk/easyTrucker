AutoForm.addInputType('rating'
,template:'afRating'

,valueOut:()->
  res=$("##{@context.id}").data('userrating')
  console.log res
  res

,contextAdjust:(context)->
  if _.isUndefined(context.atts['id'])  and _.isString(context.atts["data-schema-key"])
    context.atts['id']=context.atts['data-schema-key']

  unless context.atts['mutable'] then context.atts.hide=false
  context
)