Template.registerHelper 'formatStatus',(status)->
  switch status
    when 'new' then 'label-warning'
    when 'bidded' then 'label-info'
    when 'scheduled' then 'label-success'
    when 'done' then 'label-primary'
    when 'declined'  then  'label-inverse'
    when 'expired'  then  'label-danger'
    else  'label-default'

