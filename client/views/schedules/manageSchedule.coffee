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
      data.pickupLocation.geometry.loc=
        GeoDataHelper.createPointGeoJSON(data.pickupLocation.geometry.lng,data.pickupLocation.geometry.lat)

      data.dropOffLocation.geometry.loc=
        GeoDataHelper.createPointGeoJSON(data.dropOffLocation.geometry.lng,data.dropOffLocation.geometry.lat)
      ###find trucks and companies to append to###
      ###volume dimension###
      distFromPickup=GeoJSON.pointDistance(data.pickupLocation.geometry.loc,data.dropOffLocation.geometry.loc)

      data.shipmentDistance=distFromPickup

      Meteor.call 'searchTrucks',{$group:_id:null,dist:$max:'$dropOffSettings.coverageDistance.value'},(err,res)->
        if res
          matchObj=TruckHelpers.getTruckSpecsQuery(data.specs)

          _.extend(matchObj,{$or:[{'baseLocation.geometry.loc':{$geoWithin:$centerSphere:[data.pickupLocation.geometry.loc.coordinates
            ,Converters.metersToRadians(res[0].dist)]}},{'pickupSettings.coverage':$in:['international','usa']}]}
          ,{$or:['dropoffSettings.coverage':$in:['international','usa'],{'dropoffSettings.coverageDistance.value':$gte:distFromPickup}]})
          ###geoSpatQry=$geoNear:{near:data.pickupLocation.geometry.loc
            ,distanceField:'dist.calculated',maxDistance:5000,query:matchObj,spherical:true,includeLocs:'distance.location'}###
          console.log matchObj;

          pipeline=[$match:matchObj,{$group:_id:'$owner',trucks:$push:'$_id'}]

          console.log pipeline

          Meteor.call 'searchTrucks',pipeline,(err,res)->
            unless err
              console.log res
              if res
                data.truckers=({owner:item._id,trucks:item.trucks} for item in res)
                data.status=STATE_MATCHED
              else
                data.status=STATE_UNMATCHED
              Meteor.call 'addUpdateSchedule',data, (err,res)->
                Router.go 'scheduleList' if res

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
