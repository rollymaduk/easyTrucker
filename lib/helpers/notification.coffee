@NotifyTag={}
@NotifyMessage={}
NotifyMessage.newRequest="A new load request was created"
NotifyMessage.newBid="A new bid was created"
NotifyMessage.updateRequest="load entry was changed "
NotifyMessage.updateBid=(rate,delivery)->
  "bid entry was changed to rate=#{rate} | Estimated delivery=#{delivery} "
NotifyTag.updateBid="bidEdit"
NotifyTag.newBid="bidCreate"
NotifyTag.newRequest="RequestCreate"
NotifyTag.updateRequest="RequestEdit"