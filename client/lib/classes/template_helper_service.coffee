class @TemplateHelperService
  getPlaceBidView=(bid,isView)->
    switch
      when not bid and isView then 'warning'
      when  not bid and not isView then 'new'
      when  bid and isView then  'summary'
      else 'edit'



