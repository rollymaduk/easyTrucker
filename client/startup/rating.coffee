Meteor.startup ->
  Rp_Rating.setConfig([{name:'shipperRating',data:[
      {title:TITLE_ACCURACY,description:TEXT_ACCURACY,value:0}
      {title:TITLE_PERFORMANCE,description:TEXT_PERFORMANCE,value:0}
      {title:TITLE_TIMELINESS,description:TEXT_TIMELINESS,value:0}
    ]}])