Template.afUploadCare.rendered=->
  console.log @
  widget = uploadcare.Widget('[role=uploadcare-uploader]')
  widget.onUploadComplete (fileInfo)=>
    ###@data.photos=fileInfo.uuid###

AutoForm.addInputType('uploadCare'
,template:'afUploadCare'

,valueOut:()->
  @val()

,contextAdjust:(context)->
  defaults={
    'data-multiple':true
    'data-clearable':true
    'data-images-only':true
    'data-preview-step':true
    'data-crop':"400:300"
  }
  if _.isUndefined(context.atts['id'])  and _.isString(context.atts["data-schema-key"])
    context.atts['id']=context.atts['data-schema-key']
  options=_.extend(defaults,context.atts['options'])
  context.atts= _.extend(context.atts,options)
  context
)