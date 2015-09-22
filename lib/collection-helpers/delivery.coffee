Deliveries.helpers
  scheduleItem:()->
    Schedules.findOne(@schedule,CommonHelpers.getScheduleFieldsLight())
  Dfiles:()->
    if @files then eZFiles.find({_id:$in:@files}).fetch() else []

  toBeRated:()->
    Ratings.findOne({schedule:@schedule,$or:[{owner:$nin:[Meteor.userId()]},child:$nin:[Meteor.userId()]]})


  viewedByChild:()->
    Ratings.find(child:Meteor.userId()).count()
