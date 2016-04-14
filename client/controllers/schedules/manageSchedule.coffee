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
  goodTypes:->
    CloudspiderTags.find({},{sort:name:1}).map (doc)->
      {label: doc.name, value:doc._id};




Template.memo.events
  'change select[data-schema-key="typeOfGood"]':(evt,temp)->
    console.log evt.target.value
    volumeType=CloudspiderTags.findOne(evt.target.value).loadType
    TruckHelpers.setVolumeVisibility volumeType,temp,'mf'

saveAndReturnToList=(data)->
  Meteor.call('addUpdateSchedule',data,(err,res)->
    unless err
      Router.go('home')
  )

Template.manageSchedule.created=->
  @goodTypesSub=ddpTruckSearch.subscribe('goodTypes')

Template.manageSchedule.destroyed=->
  @goodTypesSub.stop()

Template.manageSchedule.helpers
  onfinished:->
    scheduleId=@_id||null
    (e)->
      data=@getAllData()
      data._id=scheduleId
      data.specs.volumeType=CloudspiderTags.findOne(data.typeOfGood).loadType
      Meteor.call 'addUpdateSchedule',data,(err,res)->
        unless err then Router.go 'scheduleList' else console.log err


  oncanceled:->
    (e)->Router.go 'scheduleList'
  steps:->
    [
      {
      title:"Memo"
      id:"mf"
      template:Template.memo
      data:@||{}
      },
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
        onValidate:(context,dropoff,currentStep)->
          pickup=context.getPreviousData(currentStep)
          pDate=pickup.pickupDate.dateField_2 or pickup.pickupDate.dateField_1
          dDate=dropoff.dropOffDate.dateField_2 or dropoff.dropOffDate.dateField_1
          isValid=dDate>=pDate
          unless isValid then dropSchemaContext.addInvalidKeys [{name:'dropOffDate.context',type:'invalidDate'}]
          isValid
      }

    ]

AutoForm.hooks
  mf:
    docToForm:(doc)->
      if doc?.typeOfGood
        doc.typeOfGood=doc?.typeOfGood?._id
      if doc?.specs?.weight?.value
        doc.specs.weight.value=Converters.convertWeightFromKg(doc?.specs?.weight?.value,doc?.specs?.weight?.metric)
      if doc?.specs?.boxedVolume
        unless _.isEmpty(doc.specs.boxedVolume)
          doc.specs.boxedVolume.length=Converters.convertSizeFromFeet(doc.specs.boxedVolume.length,doc.specs.boxedVolume.metric)
          doc.specs.boxedVolume.width=Converters.convertSizeFromFeet(doc.specs.boxedVolume.width,doc.specs.boxedVolume.metric)
          doc.specs.boxedVolume.height=Converters.convertSizeFromFeet(doc.specs.boxedVolume.height,doc.specs.boxedVolume.metric)
      if doc?.specs?.liquidVolume
        unless _.isEmpty(doc.specs.liquidVolume)
          doc.specs.liquidVolume.value=Converters.convertVolumeFromLitre(doc.specs.liquidVolume.value,doc.specs.liquidVolume.metric)
      doc
    formToDoc:(doc)->
      if doc?.typeOfGood
        doc.typeOfGood=_.pick(CloudspiderTags.findOne(doc.typeOfGood),"_id","name")
      if doc?.specs?.weight?.value
        doc.specs.weight.value=Converters.convertWeightToKg(doc?.specs?.weight?.value,doc?.specs?.weight?.metric)
      if doc?.specs?.boxedVolume
        unless _.isEmpty(doc.specs.boxedVolume)
          doc.specs.boxedVolume.length=Converters.convertSizeToFeet(doc.specs.boxedVolume.length,doc.specs.boxedVolume.metric)
          doc.specs.boxedVolume.width=Converters.convertSizeToFeet(doc.specs.boxedVolume.width,doc.specs.boxedVolume.metric)
          doc.specs.boxedVolume.height=Converters.convertSizeToFeet(doc.specs.boxedVolume.height,doc.specs.boxedVolume.metric)
      if doc?.specs?.liquidVolume
        unless _.isEmpty(doc.specs.liquidVolume)
          doc.specs.liquidVolume.value=Converters.convertVolumeToLitre(doc.specs.liquidVolume.value,doc.specs.liquidVolume.metric)
      doc
