Form.UpgradePlan=new SimpleSchema
  plans:
    type:String
    allowedValues:_.map(Meteor?.settings?.public?.paymentPlans,(item)->item.name)
    autoform:
      options:()->
        _.map(Meteor?.settings?.public?.paymentPlans,(item)->
          {label:item?.description,value:item?.name}
        )
