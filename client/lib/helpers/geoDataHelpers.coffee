@GeoDataHelper={}
GeoDataHelper.createPointGeoJSON=(lng,lat)->
  if lng and lat then {type:"Point",coordinates:[lng,lat]} else null