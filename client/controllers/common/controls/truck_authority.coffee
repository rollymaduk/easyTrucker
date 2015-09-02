Template.truckAuthorityControl.created=()->
  @truckAuthNumVisibility=new ReactiveVar(true)

toggleTruckAuthNumVisibility=(type,rVar)->
  switch type
    when 'NONE' then rVar.set(true)
    else rVar.set(false)

Template.truckAuthorityControl.events
  'change [data-schema-key="truckAuthorityType"]':(evt,temp)->
    toggleTruckAuthNumVisibility(evt.target.value,temp.truckAuthNumVisibility)

Template.truckAuthorityControl.rendered=()->
  temp=@
  item=$('[data-schema-key="truckAuthorityType"]').val()
  toggleTruckAuthNumVisibility(item,@truckAuthNumVisibility)
  @autorun((c)=>
    $('.ctrl-visible').parent().toggleClass('hidden',temp.truckAuthNumVisibility.get())
  )
