Schema.userSettings=new SimpleSchema
  canNotify:
    type:Boolean
    label:"Show Notification"
    defaultValue:true
    optional:true
  defaultAlertSound:
    optional:true
    type:String
    label:"Notification sound"
    allowedValues:SOUNDS
    defaultValue:"new_alert"
    autoform:
      options:"allowed"
  emailTypes:
    optional:true
    label: "Send emails for transaction states"
    type:[String]
    defaultValue:ALL_ACTIVE_STATES
    allowedValues:ALL_ACTIVE_STATES
    autoform:
      options:"allowed"
      type:"fancy-checkbox"
      class:"checkbox-success"
  reminder:
    optional:true
    type:[String]
    label:"Set reminder for"
    allowedValues:[STATE_EXPIRE,STATE_DISPATCH,STATE_SUCCESS]
    defaultValue:[STATE_EXPIRE,STATE_DISPATCH,STATE_SUCCESS]
    autoform:
      options:"allowed"
      type:"select-checkbox-inline"
  reminderPeriod:
    optional:true
    label:"Reminder starts"
    type:Number
    allowedValues:[0,1,3,5]
    defaultValue:1
    autoform:
      options:[
        {value:0,label:"Never"}
        {value:1,label:"A Day Before"}
        {value:3,label:"3 Days Before"}
        {value:5,label:"5 Days Before"}
      ]



Schema.User=new SimpleSchema
  username:
    type:String
    optional:true
  emails:
    type:[Object]
    optional:true
  'emails.$.address':
    type:String
    regEx:SimpleSchema.RegEx.Email
  'emails.$.verified':
    type:Boolean
  createdAt:
    type:Date
  services:
    type: Object,
    optional: true,
    blackbox: true
  profile:
    type:Schema.Profile
    optional:true
  settings:
    type:Schema.userSettings
    optional:true
    blackbox:true
  appPlans:
    type: Object,
    optional: true,
    blackbox: true
  roles:
    type:Object
    blackbox:true
    optional:true
