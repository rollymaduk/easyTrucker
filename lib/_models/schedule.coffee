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
  wayBill:
    type:String
    label:"Way Bill #"
  sender:
    type:String
    label:"Pick up Customer"
  pickupDate:
    type:Date
    autoform: {
      afFieldInput: {
        type: 'bootstrap-datetimepicker'
      }
    }
  pickupLocation:
    type:Schema.AddressSchema

Schema.DropOff=new SimpleSchema
  receiver:
    type:String
  dropOffDate:
    type:Date
    autoform: {
      afFieldInput: {
        type: 'bootstrap-datetimepicker'
      }
    }
  dropOffLocation:
    type:Schema.AddressSchema

Schema.AddressPropertySchema=new SimpleSchema
  address:
    type:Schema.AddressSchema
    autoform:
      type:'googleplace'

Schema.Memo=new SimpleSchema
  specs:
    label:"Van Specifications"
    type:Schema.TruckSpecs
    optional:true
  truckers:
    type:[String]
    defaultValue:[]
    autoform:
      type:"hidden"
      label:false
  memo:
    type:String
    optional:true
    autoform:
      afFieldInput:
        rows:8

Schema.Artifacts=new SimpleSchema
  artifacts:
    type:[Schema.Artifact]
    optional:true

Schema.Schedule=new SimpleSchema
  status:
    type:String
    allowedValues:["new","declined","scheduled","done",'expired','inactive']
    defaultValue:"new"
  rate:
    type:Number
    defaultValue:0
    optional:true
  truck:
    type:String
    optional:true
  driver:
    type:String
    max:250
    optional:true



