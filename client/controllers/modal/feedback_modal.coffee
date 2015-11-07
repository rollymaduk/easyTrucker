Template.feedbackModal.events
  'click .save-modal':(evt,temp)->
    Rp_Rating.saveRatingResults(temp.data.name,(err,res)->
      if res then Modal.hide() else console.log err
    )

