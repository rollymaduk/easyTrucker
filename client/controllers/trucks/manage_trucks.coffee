Template.truckSpecsCustom.replaces "truckSpecs"
Template.truckGeofenceCustom.replaces "truckGeofence"

Template.truckGeofence.created=->
  @isPickupDistance=new ReactiveVar("hidden")
  @isDropoffDistance=new ReactiveVar("hidden")



Template.truckGeofence.rendered=->
  if @data.dropoffSettings
    TruckHelpers.setCoverageVisibility(@data.dropoffSettings.coverage,@isDropoffDistance,@)
  if @data.pickupSettings
    TruckHelpers.setCoverageVisibility(@data.pickupSettings.coverage,@isPickupDistance,@)
  @autorun ->
    if GoogleMaps.loaded()
      $('input[data-schema-key="baseLocation.address"]').geocomplete
        details:".geometry"
        detailsAttribute:"data-geo"
      null

Template.truckGeofence.helpers
  isPickupDistance:->
    Template.instance().isPickupDistance.get()
  isDropoffDistance:->
    Template.instance().isDropoffDistance.get()

Template.truckGeofence.events
  'change select[data-schema-key="pickupSettings.coverage"]':(evt,temp)->
    TruckHelpers.setCoverageVisibility(evt.target.value,temp.isPickupDistance,temp)

  'change select[data-schema-key="dropoffSettings.coverage"]':(evt,temp)->
    TruckHelpers.setCoverageVisibility(evt.target.value,temp.isDropoffDistance,temp)

Template.truckSpecs.created=->
  @isLiquid=new ReactiveVar("hidden")
  @isBoxed=new ReactiveVar("hidden")
  @hasDoors=new ReactiveVar("hidden")

Template.truckSpecs.rendered=->
  if @data.typeId
    truckVolType=TruckTypes.findOne(@data.typeId)?.loadType
    TruckHelpers.setVolumeVisibility truckVolType,@,'truckSpecsForm' if truckVolType


Template.truckSpecs.helpers
  isLiquid:->
    Template.instance().isLiquid.get()
  isBoxed:->
    Template.instance().isBoxed.get()
  hasDoors:->
    Template.instance().hasDoors.get()

  truckSelectize:->
    options:->
      TruckTypes.find({},{sort:{name:1}})
    valueField: "_id"
    searchField:"name"
    sortField:[{field:"name",direction:"asc"}]
    render:
      option:(item,escape)->
        console.log item
        Blaze.toHTMLWithData(Template.selectizeImageList,{data:item.name,photo:item.photo})

      item:(item,escape)->
        "<div>#{escape(item.name)}</div>"




Template.truckSpecs.events
  'change select[data-schema-key="type"]':(evt,temp)->
    console.log evt.target.value
    truckVolumeType=TruckTypes.findOne(evt.target.value).loadType
    console.log truckVolumeType
    TruckHelpers.setVolumeVisibility truckVolumeType,temp,'truckSpecsForm'

Template.manageTruck.created=->
  @goodTypesSub=ddpTruckSearch.subscribe('goodTypes')
  @truckTypesSub=ddpTruckSearch.subscribe('trucks')


Template.manageTruck.destroyed=->
  @goodTypesSub.stop()
  @truckTypesSub.stop()

Template.manageTruck.helpers
  onfinished:->
    truckId=@_id||null
    (e)->
      data=@getAllData()
      data._id=truckId
      data.volumeType=TruckTypes.findOne(data.type).loadType
      data.typeId=data.type
      data.type=TruckTypes.findOne(data.type).name
      Meteor.call 'addUpdateTruck',data,(err,res)->
        unless err then Router.go('truckList') else console.log err

  oncanceled:->
    (e)->Router.go('truckList')

  steps:->
    [
      {
        title:"Features"
        id:"truckSpecsForm"
        template:Template.truckSpecs
        data:@||{}
      },
      {
        title:"GeoTracking"
        id:"truckGeofenceForm"
        template:Template.truckGeofence
        data:@||{}
      },
      {
      title:"General"
      id:"truckGeneralForm"
      template:Template.truckGeneral
      data:@||{}
      },
      {
        title:"Insurance"
        id:"truckInsuranceForm"
        template:Template.truckInsurance
        data:@||{}
      }

    ]

AutoForm.hooks
  truckGeofenceForm:
    docToForm:(doc)->
      unless _.isEmpty(doc.pickupSettings.coverageDistance)
        val=doc.pickupSettings.coverageDistance.value
        metric=doc.pickupSettings.coverageDistance.metric
        doc.pickupSettings.coverageDistance.value=Converters.convertDistanceFromMeter(val,metric)
      unless _.isEmpty(doc.dropoffSettings.coverageDistance)
        val=doc.dropoffSettings.coverageDistance.value
        metric=doc.dropoffSettings.coverageDistance.metric
        doc.dropoffSettings.coverageDistance.value=Converters.convertDistanceFromMeter(val,metric)
      doc

    formToDoc:(doc)->
      unless _.isEmpty(doc.pickupSettings.coverageDistance)
        val=doc.pickupSettings.coverageDistance.value
        metric=doc.pickupSettings.coverageDistance.metric
        doc.pickupSettings.coverageDistance.value=Converters.convertDistanceToMeter(val,metric)
      unless _.isEmpty(doc.dropoffSettings.coverageDistance)
        val=doc.dropoffSettings.coverageDistance.value
        metric=doc.dropoffSettings.coverageDistance.metric
        doc.dropoffSettings.coverageDistance.value=Converters.convertDistanceToMeter(val,metric)
      doc


  truckSpecsForm:
    docToForm:(doc)->
      doc.weight.value=Converters.convertWeightFromKg(doc.weight.value,doc.weight.metric)
      unless _.isEmpty(doc.boxedVolume)
        doc.boxedVolume.length=Converters.convertSizeFromFeet(doc.boxedVolume.length,doc.boxedVolume.metric)
        doc.boxedVolume.width=Converters.convertSizeFromFeet(doc.boxedVolume.width,doc.boxedVolume.metric)
        doc.boxedVolume.height=Converters.convertSizeFromFeet(doc.boxedVolume.height,doc.boxedVolume.metric)
      unless _.isEmpty(doc.liquidVolume)
        doc.liquidVolume.value=Converters.convertVolumeFromLitre(doc.liquidVolume.value,doc.liquidVolume.metric)
      doc
    formToDoc:(doc)->
      doc.weight.value=Converters.convertWeightToKg(doc.weight.value,doc.weight.metric)
      unless _.isEmpty(doc.boxedVolume)
        doc.boxedVolume.length=Converters.convertSizeToFeet(doc.boxedVolume.length,doc.boxedVolume.metric)
        doc.boxedVolume.width=Converters.convertSizeToFeet(doc.boxedVolume.width,doc.boxedVolume.metric)
        doc.boxedVolume.height=Converters.convertSizeToFeet(doc.boxedVolume.height,doc.boxedVolume.metric)
      unless _.isEmpty(doc.liquidVolume)
        doc.liquidVolume.value=Converters.convertVolumeToLitre(doc.liquidVolume.value,doc.liquidVolume.metric)
      doc

