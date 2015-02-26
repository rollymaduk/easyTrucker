Schema.Artifact=new SimpleSchema
  title:
    type:String
    optional:true
  type:
    type:String
    defaultValue:'file'
    allowedValues:['location','comment','file','photo','video','audio']
  payload:
    type:Object
    blackbox:true
    optional:true

Schema.Pickup=new SimpleSchema
  pickupDate:
    type:Date
  pickupLocation:
    type:String
    autoform:
      type:"map"
      afFieldInput:
        geolocation:true
        autolocate:true
        searchBox:true
        height:'400px'



Schema.DropOff=new SimpleSchema
  dropOffDate:
    type:Date
  dropOffLocation:
    type:String
    autoform:
      type:"map"
      afFieldInput:
        geolocation:true
        autolocate:true
        searchBox:true
        height:'400px'

Schema.Memo=new SimpleSchema
  Memo:
    type:String
    optional:true
    autoform:
      afFieldInput:
        rows:6



Schema.Artifacts=new SimpleSchema
  artifacts:
    type:[Schema.Artifact]
    optional:true


Schema.Schedule=new SimpleSchema
  status:
    type:String
    allowedValues:["request","declined","scheduled","completed",'inactive']
    defaultValue:"request"
    autoform:
      type: "hidden"
      label:false
  owner:
    type:String
    defaultValue:'admin'
    max:250
  transport:
    type:String
    optional:true
    autoform:
      type: "hidden"
      label:false
  handler:
    type:String
    max:250
    optional:true
    autoform:
      type: "hidden"
      label:false
