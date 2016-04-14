Template.scheduleDetail.created=()->
  @photos=new ReactiveVar([])
  files=@data?.memo?.files
  if files
    uploader_utils.getGroupPhotosFromSrc(files,80,(err,res)=>
      if res then @photos.set(res) else console.log err
    )


Template.scheduleDetail.rendered=()->
  Rp_Comment.setFilter({parent:@data._id})
  hash=Router.current()?.params?.hash
  if hash
    $(document).arrive("##{hash}",()->
      Eztrucker.Utils.General.navigateToContent(hash,()->
        $(document).unbindArrive("##{hash}");
      )

      return
    )
    return
  return


Template.scheduleDetail.helpers
  files:->
    Template.instance().photos.get()




