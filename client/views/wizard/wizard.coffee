Template.Wizard.created=->
  Template.Wizard.prepareOptions()
  Template.Wizard.prepareSteps()

Template.Wizard.resizeContent=(template,id)->
  resizeHeight=template.$("form[id='#{id}']").height()+100
  console.log resizeHeight
  template.$(".wizard>div.content").height(resizeHeight)


Template.Wizard.rendered=->
  that=@
  console.log that
  console.log Template.Wizard
  steps=Template.Wizard.getData().steps;
  @$('#wizard').steps
    bodyTag:Template.Wizard.getData().options.bodyTag
    headerTag:Template.Wizard.getData().options.headerTag
    onStepChanging: (event, currentIndex, newIndex)->
      console.log 'step changing'
      isValid=true
      step=steps[currentIndex]
      step.index=currentIndex
      step.data=AutoForm.getFormValues(step.id).insertDoc
      console.log step
      unless currentIndex>newIndex
        isValid=AutoForm.validateForm(step.id)
      switch
        when isValid
          if step.onSubmit then step.onSubmit.call that,step.data,step
        else
         _.delay Template.Wizard.resizeContent,200,that,step.id
      Blaze.remove Template.Wizard.myView if isValid
      isValid

    onFinishing:(event,currIndx)->
      step=steps[currIndx]
      step.data=AutoForm.getFormValues(step.id).insertDoc
      AutoForm.validateForm(step.id)

    onFinished:(event,currIndx)->
      step=steps[currIndx]
      if that.data.onFinished
       that.data.onFinished.call(that,step.data,step)
       null

    onCanceled:(evt)->
      if that.data.onCanceled
        that.data.onCanceled.call(that)

    onStepChanged:(evt,currIndx,priorIndx)->
      step=steps[currIndx]
      console.log "step changed"
      Template.Wizard.displayContent(step,that)
      null
  Template.Wizard.initialize(that)

getObjects=(steps)->
  obj = {}
  obj = _.extend obj, step.data for step in steps
  obj

Template.Wizard.initialize=(template)->
  @displayContent(@getData().steps[0],template)

  template.getAllData=->
    steps=template.data.steps
    getObjects(steps)

  template.getPreviousData=(step,include)->
    include=include||true
    steps=if include then template.data.steps[..step.index] else template.data.steps[...step.index]
    getObjects(steps)



Template.Wizard.displayContent=(step,template)->
  data="content-#{step.id}"
  parent=template.$("section[data-content='#{data}']")
  @myView=Blaze.renderWithData(step.template,step.data,parent[0])
  @resizeContent(template,step.id)
  console.log @myView
  null


Template.Wizard.prepareSteps=()->
  steps=@getData().steps
  unless steps
    steps=[]
  @setData('steps',steps)


Template.Wizard.myView={}

Template.Wizard.prepareOptions=()->
  options=@getData().options or {}
  @setData('options',_.defaults(options,@defaultOptions))

Template.Wizard.defaultOptions=
  bodyTag:'section'
  headerTag:'h1'


Template.Wizard.getData=->
  Template.currentData() or false

Template.Wizard.setData=(key,data)->
  Template.currentData()[key]=data
