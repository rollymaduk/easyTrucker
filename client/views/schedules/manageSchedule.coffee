Template.pickupCustom.replaces "pickup"
Template.dropOffCustom.replaces "dropOff"
Template.memoCustom.replaces "memo"

Template.memo.created=->
  @isLiquid=new ReactiveVar("hidden")
  @isBoxed=new ReactiveVar("hidden")
  @hasDoors=new ReactiveVar("hidden")

Template.memo.rendered=->
  voltype=@data?.specs?.volumeType
  if voltype
    TruckHelpers.setVolumeVisibility @data.specs.volumeType,@,'mf'

Template.memo.helpers
  isLiquid:->
    Template.instance().isLiquid.get()
  isBoxed:->
    Template.instance().isBoxed.get()
  hasDoors:->
    Template.instance().hasDoors.get()


Template.memo.events
  'change select[data-schema-key="specs.volumeType"]':(evt,temp)->
    TruckHelpers.setVolumeVisibility evt.target.value,temp,'mf'

saveAndReturnToList=(data)->
  Meteor.call('addUpdateSchedule',data,(err,res)->
    unless err
      Router.go('home')
  )

Template.manageSchedule.helpers
  onfinished:->
    scheduleId=@_id||null
    (e)->
      data=@getAllData()
      data._id=scheduleId

      Meteor.call 'addUpdateSchedule',data,(err,res)->
        unless err then Router.go 'scheduleList' else console.log err


  oncanceled:->
    (e)->Router.go 'scheduleList'
  steps:->
    [
      {
      title:"Pick up"
      id:"puf"
      template:Template.pickup
      data:@||{}
      },
      {
        title:"Drop Off"
        id:"dof"
        template:Template.dropOff
        data:@||{}
      },
      {
        title:"Memo"
        id:"mf"
        template:Template.memo
        data:@||{}
      }

    ]

AutoForm.hooks
  mf:
    docToForm:(doc)->
      unless _.isEmpty(doc.specs.boxedVolume)
        doc.specs.boxedVolume.length=Converters.convertSizeFromFeet(doc.specs.boxedVolume.length,doc.specs.boxedVolume.metric)
        doc.specs.boxedVolume.width=Converters.convertSizeFromFeet(doc.specs.boxedVolume.width,doc.specs.boxedVolume.metric)
        doc.specs.boxedVolume.height=Converters.convertSizeFromFeet(doc.specs.boxedVolume.height,doc.specs.boxedVolume.metric)
      unless _.isEmpty(doc.specs.liquidVolume)
        doc.specs.liquidVolume.value=Converters.convertVolumeFromLitre(doc.specs.liquidVolume.value,doc.specs.liquidVolume.metric)
      doc
    formToDoc:(doc)->
      unless _.isEmpty(doc.specs.boxedVolume)
        doc.specs.boxedVolume.length=Converters.convertSizeToFeet(doc.specs.boxedVolume.length,doc.specs.boxedVolume.metric)
        doc.specs.boxedVolume.width=Converters.convertSizeToFeet(doc.specs.boxedVolume.width,doc.specs.boxedVolume.metric)
        doc.specs.boxedVolume.height=Converters.convertSizeToFeet(doc.specs.boxedVolume.height,doc.specs.boxedVolume.metric)
      unless _.isEmpty(doc.specs.liquidVolume)
        doc.specs.liquidVolume.value=Converters.convertVolumeToLitre(doc.specs.liquidVolume.value,doc.specs.liquidVolume.metric)
      doc
