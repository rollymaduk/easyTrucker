Meteor.methods
  sendCallToActionEmail:(to,subject,heading,message,buttonText,link)->
    this.unblock()
    audience=if _.isArray(to) then to else [to]
    _.each(audience,(val)->
      PrettyEmail.send 'call-to-action',
        to: val
        subject: subject
        heading: heading
        message: message
        buttonText: buttonText
        buttonUrl: link
    )


