###@flow###
class @Rp_payment
  _meteor=undefined ;_validator=undefined
  constructor:(meteor,validator,payment={})->
    _meteor=meteor
    _validator=validator
    _validator.clean(payment)
    {@id,@customer,@amount,@date,@status,@owner,@description}=payment
  add:(isTrustedCode,callback)->
    _payment={@id,@customer,@amount,@date,@status,@owner,@description}
    _meteor.call('payment/add',_payment,isTrustedCode,(err,res)->
      console.log err or res
      callback.call @,err,res if callback
    )
    return


class @Rp_PaymentProvider
  _collection=undefined
  _utility=undefined
  constructor:(collection,utility)->
    _collection=collection
    _utility=utility

  getPayments:(query={},modify={})->
    _utility.payQuery.set(query)
    _utility.payMod.set(modify)
    _collection.find(query,modify).fetch()


@PaymentProvider=new Rp_PaymentProvider(pSUtility?.Collections?.Payments,pSUtility)