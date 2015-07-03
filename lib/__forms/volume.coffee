Form.LiquidVolume=new SimpleSchema
  capacity:
    type:Number


Form.BoxVolume=new SimpleSchema
  length:
    type:Number
    label:"Length(feet)"
    optional:true
    autoform:
      label:false
      placeholder:"schemaLabel"
  width:
    type:Number
    label:"Width(feet)"
    optional:true
    autoform:
      label:false
      placeholder:"schemaLabel"
  height:
    type:Number
    label:"Height(feet)"
    optional:true
    autoform:
      label:false
      placeholder:"schemaLabel"
