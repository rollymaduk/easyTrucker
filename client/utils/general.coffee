Eztrucker.Utils.General={
  navigateToContent:(hash,callback)->
    $('html,body').pulse({scrollTop:$("##{hash}").offset().top-100},{duration:2000},()->
      $("##{hash}").pulse({opacity:0.1},{duration:100,pulses:5})
      if callback then callback.call null
      return
    )
    return


}