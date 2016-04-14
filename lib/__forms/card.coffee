Form.ChangeCard=new SimpleSchema
   customer:
     type:String
     optional:true
     autoform:
      type:"hidden"
      label:false
   exp_month:
     type:String
     optional:true
   exp_year:
     type:String
     optional:true
   id:
     type:String
     optional:true
     autoform:
      type:"hidden"
      label:false


Form.AddCard=new SimpleSchema
  cvc:
    type:String
    optional:true
  exp_month:
    type:String
    optional:true
  exp_year:
    type:String
    optional:true
  number:
    type:String
    optional:true

