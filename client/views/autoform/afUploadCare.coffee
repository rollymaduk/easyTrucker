Template.afUploadCare.rendered=->
  console.log @
  widget = uploadcare.Widget('[role=uploadcare-uploader]')

  isMultiple=@data.uc_options.isMultiple
  if isMultiple
    Eztrucker.Utils.Photo.installWidgetPreviewMultiple(widget)
  else
    Eztrucker.Utils.Photo.installWidgetPreviewSingle(widget)



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
    'data-crop':true
  }
  if _.isUndefined(context.atts['id'])  and _.isString(context.atts["data-schema-key"])
    context.atts['id']=context.atts['data-schema-key']
  context['uc_options']=_.extend(defaults,context.atts['uc_options'])
  context['uc_options']['isMultiple']=context['uc_options']['data-multiple']
  context.atts=_.omit(context.atts,'uc_options')
  context
)