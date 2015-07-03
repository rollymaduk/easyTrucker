@TruckHelpers={}
TruckHelpers.resizeWidget=(height,template,id)->
  if Meteor.isClient
    resizeHeight=template.$("form[id='#{id}']").height()+ height
    $(".wizard>div.content").height(resizeHeight)
  else console.log "Client Only"

TruckHelpers.setVolumeVisibility=(caseItem,temp,id)->
  if Meteor.isClient
    switch caseItem
      when 'boxed'
        temp.isBoxed.set(null)
        temp.hasDoors.set(null)
        temp.isLiquid.set('hidden')
      when 'liquid'
        temp.isBoxed.set('hidden')
        temp.hasDoors.set('hidden')
        temp.isLiquid.set(null)
      else
        temp.isBoxed.set('hidden')
        temp.isLiquid.set('hidden')
        temp.hasDoors.set('hidden')
    _.delay @resizeWidget,200,100,temp,id
  else console.log 'Client only!'

TruckHelpers.setCoverageVisibility=(caseItem,element,temp)->
  if Meteor.isClient
    switch caseItem
      when 'distance' then element.set(null)
      else
        element.set('hidden')
    _.delay @resizeWidget,200,100,temp,'truckGeofenceForm'
  else console.log 'Client only!'

TruckHelpers.getTruckSpecsQuery=(specsObj,prefix,reverse)->
  prefix=prefix||''
  reverse=reverse||false
  matchObj={}
  for prop,val of specsObj
    switch prop
      when 'boxedVolume'
        for volprop,volval of specsObj.boxedVolume
          if _.isNumber(volval)
            matchObj["#{prefix}boxedVolume.#{volprop}"]=unless reverse then $gte:volval else $lte:volval
      when 'liquidVolume'
        for volprop,volval of specsObj.liquidVolume
          if _.isNumber(volval)
            matchObj["#{prefix}liquidVolume.#{volprop}"]=unless reverse then $gte:volval else $lte:volval
      else
        if val
          matchObj["#{prefix}#{prop}"]=if _.isNumber(val)
            unless reverse then $gte:val else $lte:val
          else val
  matchObj

TruckHelpers.buildTruckMatchQuery=(specsObj,prefix,reverse,coordinates,radius,distance)->
  truck_qry=@getTruckSpecsQuery(specsObj,prefix,reverse)

  _.extend(truck_qry,{status:$in:[STATE_UNMATCHED,STATE_MATCHED]})

  if distance
    _.extend(truck_qry,'shipmentDistance':$lte:distance)

  if radius
    _.extend(truck_qry,'pickupLocation.geometry.loc':{$geoWithin:$centerSphere:[coordinates,Converters.metersToRadians(radius)]});

  truck_qry