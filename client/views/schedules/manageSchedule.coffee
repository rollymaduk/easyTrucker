Template.pickupCustom.replaces "pickup"
Template.dropOffCustom.replaces "dropOff"

Template.manageSchedule.created=->

saveAndReturnToList=(data)->
  Meteor.call('addUpdateSchedule',data,(err,res)->
    unless err
      Router.go('home')
  )

Template.manageSchedule.helpers
  onfinished:->
    scheduleId=@._id||null
    (e)->
      data=@getAllData()
      data._id=scheduleId
      data.status='new'
      ###find trucks and companies to append to###
      ###volume dimension###

      matchObj={}
      for prop,val of data.specs
        unless prop is 'volume'
          matchObj["truckSpecs.#{prop}"]=if _.isNumber(val) then $gte:val else val
        else
          for volprop,volval of data.specs.volume
            matchObj["truckSpecs.volume.#{volprop}"]=$gte:volval

      ###,$group:{_id:"$owner",trucks:$sum:1}###


      ###console.log matchObj;###
      pipeline=[{$match:matchObj},$project:owner:1]
      console.log pipeline
      Meteor.call 'searchTrucks',pipeline,(err,res)->
        unless err
          data.truckers=(item.owner for item in res)
          console.log res
          unless res.length>0
            swal
              type:'warning'
              text:'There was no Trucker found with your current specs!You can modify your specs or allow the system keep looking
and make matches when available.'
              title:"Opps no Truckers found!"
              showCancelButton:true
              confirmButtonText:"modify specs now!"
              cancelButtonText:"match when available!"
              closeOnConfirm:false
              ,(isConfirm)->
                switch isConfirm
                  when on
                    ###go to trucker search page###
                  else
                    saveAndReturnToList data
          else
            saveAndReturnToList data


      ###console.log data###
      ###Meteor.call('addUpdateSchedule',data,(err,res)->
        console.log res
      )###
  oncanceled:->
    (e)->Router.go('home')
  steps:->
    [{
      title:"Pick up"
      id:"puf"
      template:Template.pickup
      data:@||{}
    },
      {
        title:"Drop Off"
        id:"dof"
        template:Template.dropOff
        data:@||{}
      },
      {
        title:"Memo"
        id:"mf"
        template:Template.memo
        data:@||{}
      }
    ]