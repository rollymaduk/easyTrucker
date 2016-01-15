Form.DuplicateScheduleForm=new SimpleSchema
  _id:
    type:String
    autoform:
      label:false
      type:"hidden"
  shipmentTitle:
    type:String
  pickupDate:
    type:Form.TimeFrame
  dropOffDate:
    type:Form.TimeFrame