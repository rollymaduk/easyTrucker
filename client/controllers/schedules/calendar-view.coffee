Template.calendarView.helpers
  options:()->
    id:'myCalendar'
    header:
      left: 'prev,next today',
      center: 'title',
      right:'month,agendaWeek,agendaDay'
    events:Template.currentData()
