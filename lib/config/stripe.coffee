AppPlans.define(SUBSCRIBE_FREE);

AppPlans.define(SUBSCRIBE_ANNUAL, {services:[{name: 'stripe'
  ,planName:'ezt_premium_yr',payOptions:{name:'Premium Yearly Plan',description:'Only $470.40/year',amount: 47040}}]
  ,includedPlans: [SUBSCRIBE_FREE,SUBSCRIBE_MONTH]});

AppPlans.define(SUBSCRIBE_MONTH, {services:[{name: 'stripe',planName: 'ezt_premium'
  ,payOptions:{name: 'Premium Plan',description: 'Only $49.00/month',amount: 4900}}]
  ,includedPlans: [SUBSCRIBE_FREE]
});