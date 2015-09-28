Schema.Dispatch=new SimpleSchema
  note:
    type:String
    optional:true
    autoform:
      afFieldInput:
        rows:5
  schedule:
    type:String
    autoform:
      label:false
      type:'hidden'
  files:
    optional:true
    type:[String]
    label: 'Choose file' # optional
  "files.$":
    autoform:
      afFieldInput:
        type: 'fileUpload'
        collection: 'eZFiles'