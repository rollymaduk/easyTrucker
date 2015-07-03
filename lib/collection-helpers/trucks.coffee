getCoverageDescription=(coverage,value,metric,label)->
  value=Converters.convertDistanceFromMeter(value,metric)
  switch coverage
    when 'distance' then "#{value} #{metric} from #{label}"
    else coverage


Trucks.helpers
  insurance:()->
    "#{@InsuranceCompany} (#{@policyNumber})"

  matches:->
    Schedules.find().count()

  pickup:()->
    distance=@pickupSettings?.coverageDistance?.value
    metric=@pickupSettings?.coverageDistance?.metric
    getCoverageDescription(@pickupSettings.coverage,distance,metric,"base location")
  dropoff:()->
    distance=@dropoffSettings?.coverageDistance?.value
    metric=@dropoffSettings?.coverageDistance?.metric
    getCoverageDescription(@dropoffSettings.coverage,distance,metric,"pickup location")
  volume:()->
    if @boxedVolume
      width=Converters.convertSizeFromFeet(@boxedVolume.width,@boxedVolume.metric)
      length=Converters.convertSizeFromFeet(@boxedVolume.length,@boxedVolume.metric)
      height=Converters.convertSizeFromFeet(@boxedVolume.height,@boxedVolume.metric)

      "W:#{width}#{@boxedVolume.metric} x L:#{length}#{@boxedVolume.metric} x H:#{height}#{@boxedVolume.metric}"
    else if @liquidVolume
      value=Converters.convertVolumeFromLitre(@liquidVolume.value,@liquidVolume.metric)
      "#{value}#{@liquidVolume.metric}"
    else 'nil'
