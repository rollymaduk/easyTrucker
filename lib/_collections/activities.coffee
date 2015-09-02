@Activities=new Meteor.Collection 'activities'
Activities.attachSchema Schema.Activity
Activities.attachBehaviour('timestampable');