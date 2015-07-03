toggleVisibility=(state,temp)->
  if state is 'between' then temp.isVisible.set(null) else temp.isVisible.set('hidden')
Template.timeFrame.created=->
  @isVisible=new ReactiveVar("hidden")

Template.timeFrame.helpers
  isVisible:->
    Template.instance().isVisible.get()

Template.timeFrame.rendered=->
  value=$('.date_context').val()
  toggleVisibility value,@

Template.timeFrame.events
  'change .date_context':(evt,temp)->
    toggleVisibility evt.target.value,temp