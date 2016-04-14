Meteor.startup ->
  @TagsUtil={
    getInputValue:(value)->
      if _.isArray(value)
        _.compact(_.map(value,(val)->val?.name)).join(',')
      else value.join(',')
    findOrCreate:(title)->
      if window.CloudspiderTags
       _.pick(CloudspiderTags.findOne({name:title}),"name","_id") or title

}