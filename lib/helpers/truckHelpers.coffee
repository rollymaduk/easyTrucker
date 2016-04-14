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
    ###_.delay @resizeWidget,200,100,temp,id###
  else console.log 'Client only!'

TruckHelpers.setCoverageVisibility=(caseItem,element,temp)->
  if Meteor.isClient
    switch caseItem
      when 'distance' then element.set(null)
      else
        element.set('hidden')
    ###_.delay @resizeWidget,200,100,temp,'truckGeofenceForm'###
  else console.log 'Client only!'

TruckHelpers.getTruckSpecsQuery=(specsObj,prefix='',reverse=false)->
  matchObj={}
  for prop,val of specsObj
    switch prop
      when 'boxedVolume'
        for volprop,volval of specsObj.boxedVolume
          if _.isNumber(volval)
            matchObj["#{prefix}boxedVolume.#{volprop}"]=unless reverse then {$gte:volval,$lte:volval/0.75} else {$lte:volval,$gte:volval*0.75}
      when 'liquidVolume'
        for volprop,volval of specsObj.liquidVolume
          if _.isNumber(volval)
            matchObj["#{prefix}liquidVolume.#{volprop}"]=unless reverse then {$gte:volval,$lte:volval/0.75} else {$lte:volval,$gte:volval*0.75}
      when 'weight'
        for volprop,volval of specsObj.weight
          if _.isNumber(volval)
            matchObj["#{prefix}weight.#{volprop}"]=unless reverse then {$gte:volval,$lte:volval/0.75} else {$lte:volval,$gte:volval*0.75}
      else
        if _.isArray(val)
          switch prop
            when 'goodsType'
              val=_.compact(_.map(val,(item)->item?._id))
              matchObj["#{prefix}#{prop}._id"]=$in:val
            else
              matchObj["#{prefix}#{prop}"]=$in:val
        else
          matchObj["#{prefix}#{prop}"]=if _.isNumber(val)
            unless reverse then $gte:val else $lte:val
          else val

  matchObj

TruckHelpers.buildTruckMatchQuery=(specsObj,prefix,reverse,coordinates,radius,distance)->
  truck_qry=@getTruckSpecsQuery(specsObj,prefix,reverse)

  _.extend(truck_qry,{status:$in:[STATE_NEW,STATE_BOOKED]})

  if distance
    _.extend(truck_qry,'shipmentDistance':$lte:distance)

  if radius
    _.extend(truck_qry,'pickupLocation.geometry.loc':{$geoWithin:$centerSphere:[coordinates,Converters.metersToRadians(radius)]});

  truck_qry