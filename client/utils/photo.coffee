Eztrucker.Utils.Photo={
 installWidgetPreviewMultiple:(widget)->
  list=$("._img-viewer")
  list.empty();
  widget.onChange (fileGroup)->
    if (fileGroup)
      $.when.apply(null, fileGroup.files()).done(()->
        $.each(arguments,(i, fileInfo)->
          src = fileInfo.cdnUrl + '-/scale_crop/160x160/center/'
          list.append($('<div/>', {'class': '_item'}).append([$('<img/>', {src: src}), fileInfo.name]))
          return
        )
        return
      )
    return
  return

 installWidgetPreviewSingle:(widget)->
   img=$("._img-viewer")
   img.css('visibility','hidden')
   img.attr('src','')
   widget.onChange((file)->
    if (file)
      file.done (fileInfo)->
        debugger
        size = "#{(img.width() * 2)}x#{(img.height() * 2)}"
        previewUrl = "#{fileInfo.cdnUrl}-/scale_crop/#{size}/center/"
        img.attr('src', previewUrl)
        img.css('visibility','visible')
        return
      return
    )
   return

  getGroupPhotosFromSrc:(src,thumbSize=60,callback)->
    check(src,String)
    unless _.isArray(thumbSize) then thumbSize=[thumbSize]
    thumb=if thumbSize.length>1 then "#{thumbSize[0]}x#{thumbSize[1]}" else "#{thumbSize[0]}x#{thumbSize[0]}"
    photos=[]
    uploadcare.loadFileGroup(src).done((fileGroup)->
      $.when.apply(null,fileGroup.files()).done(()->
        fileInfos=arguments
        $.each(fileInfos,(i,fileInfo)->
          photos.push({thumb:"#{fileInfo.cdnUrl}-/scale_crop/#{thumb}/center/",photo:fileInfo.cdnUrl})
        )
        callback.call null,null,photos
        return
    )
      return
    ).fail(()->
      err=new Meteor.Error("9001","failed to load group photos from uploadCare")
      callback.call null,err,null
      return
    )
    return


}