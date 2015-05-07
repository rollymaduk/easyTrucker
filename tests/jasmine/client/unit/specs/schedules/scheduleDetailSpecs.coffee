###
describe 'scheduleDetail',()->
  beforeEach ()->
    MeteorStubs.install()
    service= new TemplateHelperService()
    null

  afterEach ()->
    MeteorStubs.uninstall()
    null

  describe 'bid view with no bid placed',()->
    it 'should  return bid warning',(done)->
      bid=null
      expect(service.getPlaceBidView(bid,true)).toBe('warning')
      done()
      null
    null
  describe 'bid form with no bid placed',()->
    it 'should return create new bid form',(done)->
      bid=null
      expect(service.getPlaceBidView(bid)).toBe('new')
      done()
      null
    null
  describe 'bid view with existing bid',()->
    it 'should  return bid view status',(done)->
      bid={}
      expect(service.getPlaceBidView(bid,true)).toBe('summary')
      done()
      null
    null
  describe 'bid form with existing bid',()->
    it 'should return  edit bid form',(done)->
      bid=null
      expect(service.getPlaceBidView(bid)).toBe('edit')
      done()
      null
    null
  null

###
