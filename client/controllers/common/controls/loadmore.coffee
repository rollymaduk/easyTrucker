Template.loadMore.helpers
  canLoadMore:()->
    handle=Router.current().state.get('subsHandle')
    console.log handle
    if handle then handle.loaded()>=handle.limit() else false

Template.loadMore.events
  'click .load-more':(evt,temp)->
    handle=Router.current().state.get('subsHandle')
    if handle then handle.loadNextPage()