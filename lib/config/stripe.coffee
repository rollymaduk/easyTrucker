Meteor.startup ->
  if Meteor?.settings?.public?.paymentPlans?.length
    Rp_Payment.setPlanDefinitions(Meteor?.settings?.public?.paymentPlans)
  else
    console.log "No payment plan definitions setup!"


###AppPlans.define(SUBSCRIBE_FREE);

AppPlans.define(SUBSCRIBE_ANNUAL, {services:[{name: 'stripe'
  ,planName:'ezt_premium_yr',payOptions:{name:'Premium Yearly Plan',description:'Only $470.40/year',amount: 47040}}]
  ,includedPlans: [SUBSCRIBE_FREE,SUBSCRIBE_MONTH]});

AppPlans.define(SUBSCRIBE_MONTH, {services:[{name: 'stripe',planName: 'ezt_premium'
  ,payOptions:{name: 'Premium Plan',description: 'Only $49.00/month',amount: 4900}}]
  ,includedPlans: [SUBSCRIBE_FREE]
});###

###
AppPlans.define(SUBSCRIBE_PAYG, {services:[{name: 'stripe'
  ,planName:'ezt_payg_plan',payOptions:{name:'Pay-As-You-Go Plan',description:'Only $10.00/transaction',amount: 10000,counter:1}}]
  });

AppPlans.define(SUBSCRIBE_PREMIUM, {services:[{name: 'stripe'
  ,planName:'ezt_premium_plan',payOptions:{name:'Premium  Plan',description:'Only $470.40/150 transactions',amount: 47040,counter:150}}]
  });

AppPlans.define(SUBSCRIBE_STANDARD, {services:[{name: 'stripe',planName: 'ezt_standard_plan'
  ,payOptions:{name: 'Standard Plan',description: 'Only $49.00/10 transactions',amount: 4900,counter:10}}]
});###
