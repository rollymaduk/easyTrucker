Form.UpgradePlan=new SimpleSchema
  plans:
    type:String
    allowedValues:[SUBSCRIBE_ANNUAL,SUBSCRIBE_MONTH,SUBSCRIBE_FREE]
    autoform:
      options:{premium_yr:"Premium(1 Year)-$470.40",premium:"Premium(Monthly)-$49.00"}
