class @Rp_Card
  _meteor=undefined
  constructor:(meteor,validator,card={})->
    _meteor=meteor
    {@id,@last4,@exp_year,@exp_month,@customer}=card
  remove:(isTrustedCode,callback)->
    _meteor.call('card/remove',@id,isTrustedCode,(err,res)->
      console.log err or res
      callback.call @,err,res if callback
    )
  change:(isTrustedCode,callback)->
    _card={@id,@last4,@exp_year,@exp_month,@customer}
    _meteor.call('card/change',@id,_card,isTrustedCode,(err,res)->console.log err or res)
    callback.call @,err,res if callback
  add:(isTrustedCode,callback)->
    _card={@id,@last4,@exp_year,@exp_month,@customer}
    _meteor.call('card/add',_card,isTrustedCode,(err,res)->
      console.log err or res
      callback.call @,err,res if callback
    )

class @Rp_CardProvider
  _collection=undefined
  _utility=undefined
  constructor:(collection,utility)->
    _collection=collection
    _utility=utility

  getCard:(cardId)->
    _collection.findOne({id:cardId})

  getCards:(query={},modify={})->
    _utility.cardQuery.set(query)
    _utility.cardMod.set(modify)
    _collection.find(query,modify).fetch()

@CardProvider=new Rp_CardProvider(pSUtility.Collections.Cards,pSUtility)








