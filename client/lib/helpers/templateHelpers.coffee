Template.registerHelper 'formatStatus',(status)->
  switch status
    when 'new' then 'label-warning'
    when 'scheduled' then 'label-success'
    when 'done' then 'label-primary'
    when 'declined'  then  'label-inverse'
    when 'expired'  then  'label-danger'
    else  'label-default'

