@Converters={}
Converters.convertDistanceToMeter=(value,metric)->
  if _.isNumber(value)
    switch metric
      when 'km' then value * 1000
      when 'mi' then value * 1609.34
      else value
  else 0

Converters.convertDistanceFromMeter=(value,metric)->
  if _.isNumber(value)
    switch metric
      when 'km' then value / 1000
      when 'mi' then value / 1609.34
      else value
  else 0

Converters.convertVolumeToLitre=(value,metric)->
  if _.isNumber(value)
    switch metric
      when 'gal' then value * 3.78541
      when 'ft3' then value * 28.3168
      when 'bbl' then value * 119.240471
      when 'ccm' then value * 1000
      else value
  else 0

Converters.convertVolumeFromLitre=(value,metric)->
  if _.isNumber(value)
    switch metric
      when 'gal' then value / 3.78541
      when 'ft3' then value / 28.3168
      when 'bbl' then value / 119.240471
      when 'ccm' then value / 1000
      else value
  else 0

Converters.convertSizeToFeet=(value,metric)->
  if _.isNumber(value)
    switch metric
      when 'm' then value * 3.28084
      when 'cm' then value * 0.0328084
      when 'inch' then value * 0.0833333
      else value
  else 0

Converters.convertSizeFromFeet=(value,metric)->
  if _.isNumber(value)
    switch metric
      when 'm' then value / 3.28084
      when 'cm' then value / 0.0328084
      when 'inch' then value / 0.0833333
      else value
  else 0

Converters.convertWeightToKg=(value,metric)->
  if _.isNumber(value)
    switch metric
      when 'lbs' then value * 0.453592
      when 'mt' then value * 1000
      when 'cwt' then value * 50.8023
      when 'per' then value * 1
      else value
  else 0

Converters.convertWeightFromKg=(value,metric)->
  if _.isNumber(value)
    switch metric
      when 'lbs' then value / 0.453592
      when 'mt' then value / 1000
      when 'cwt' then value / 50.8023
      when 'per' then value / 1
      else value
  else 0

Converters.metersToRadians=(val)->
  if val then val/6371000 else 0