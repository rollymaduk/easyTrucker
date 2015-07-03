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
  if @data.volumeType
    TruckHelpers.setVolumeVisibility @data.volumeType,@,'truckSpecsForm'

Template.truckSpecs.helpers
  isLiquid:->
    Template.instance().isLiquid.get()
  isBoxed:->
    Template.instance().isBoxed.get()
  hasDoors:->
    Template.instance().hasDoors.get()

Template.truckSpecs.events
  'change select[data-schema-key="volumeType"]':(evt,temp)->
    TruckHelpers.setVolumeVisibility evt.target.value,temp,'truckSpecsForm'


Template.manageTruck.helpers
  onfinished:->
    truckId=@_id||null
    (e)->
      data=@getAllData()
      data._id=truckId
      data.baseLocation.geometry.loc=
        GeoDataHelper.createPointGeoJSON(data.baseLocation.geometry.lng,data.baseLocation.geometry.lat)

      truckSpecs= _.defaults({},@getStepData(Template.truckSpecs))
      Schema.TruckSpecs.clean(truckSpecs)
      radius=data.pickupSettings?.coverageDistance?.value
      distance=data.dropoffSettings?.coverageDistance?.value

      truck_qry=TruckHelpers.buildTruckMatchQuery(truckSpecs,'specs.'
      ,true,data.baseLocation.geometry.loc.coordinates,radius,distance)

      pipeline=[$match:truck_qry,{$project:_id:1}]

      Meteor.call 'addTruck',data,(err,res)->
        if res
          truck=data._id or res
          Meteor.call 'searchSchedules',pipeline,(err,res)->
            if res
              schedules=if(res.length) then _.pluck(res,'_id')else []
              Meteor.call 'updateScheduleTrucker',schedules,Meteor.userId(),truck,(err,res)->
                if err then console.log err
              Router.go 'truckList'
            else console.log err
        null
      null
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
      unless _.isEmpty(doc.boxedVolume)
        doc.boxedVolume.length=Converters.convertSizeFromFeet(doc.boxedVolume.length,doc.boxedVolume.metric)
        doc.boxedVolume.width=Converters.convertSizeFromFeet(doc.boxedVolume.width,doc.boxedVolume.metric)
        doc.boxedVolume.height=Converters.convertSizeFromFeet(doc.boxedVolume.height,doc.boxedVolume.metric)
      unless _.isEmpty(doc.liquidVolume)
        doc.liquidVolume.value=Converters.convertVolumeFromLitre(doc.liquidVolume.value,doc.liquidVolume.metric)
      doc
    formToDoc:(doc)->
      unless _.isEmpty(doc.boxedVolume)
        doc.boxedVolume.length=Converters.convertSizeToFeet(doc.boxedVolume.length,doc.boxedVolume.metric)
        doc.boxedVolume.width=Converters.convertSizeToFeet(doc.boxedVolume.width,doc.boxedVolume.metric)
        doc.boxedVolume.height=Converters.convertSizeToFeet(doc.boxedVolume.height,doc.boxedVolume.metric)
      unless _.isEmpty(doc.liquidVolume)
        doc.liquidVolume.value=Converters.convertVolumeToLitre(doc.liquidVolume.value,doc.liquidVolume.metric)
      doc

