describe "PromoterNetworksController", ->
  scope        = null
  ctrl         = null
  location     = null
  routeParams  = null
  resource     = null

  # access injected service later
  httpBackend  = null

  setupController =(page, per_page, results)->
    inject(($location, $routeParams, $rootScope, $resource, $httpBackend, $controller)->
      scope       = $rootScope.$new()
      location    = $location
      resource    = $resource
      routeParams = $routeParams
      routeParams.page = page
      routeParams.per_page = per_page

      # capture the injected service
      httpBackend = $httpBackend 

      if results
        request = new RegExp("\/promoter_networks.*format=json.*(page=#{page})?.*(per_page=#{per_page})?.*")
        httpBackend.expectGET(request).respond(results)

      ctrl        = $controller('PromoterNetworksController',
                                $scope: scope
                                $location: location)
    )

  beforeEach(module("angular_rails"))
  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()

  describe 'controller initialization', ->
    describe 'when no page is requested', ->
      promoter_networks = [
        {
          id: 1
          name: 'No page 1'
        },
        {
          id: 2
          name: 'No page 2'
        },
        {
          id: 3
          name: 'No page 3'
        }
      ]
      beforeEach ->
        setupController(null, null, promoter_networks)
        httpBackend.flush()

      it 'defaults to first page', ->
        expect(scope.promoter_networks).toEqualData(promoter_networks)

    describe 'when a given page is requested', ->
      page = 2
      per_page = 2
      promoter_networks = [
        {
          id: 21
          name: 'Page 2 item 1'
        },
        {
          id: 22
          name: 'Page 2 item 2'
        }
      ]
      beforeEach ->
        setupController(page, per_page, promoter_networks)
        httpBackend.flush()

      it 'calls the back-end', ->
        expect(scope.promoter_networks).toEqualData(promoter_networks)

    describe 'index', ->
      page = 22
      per_page = 11
      beforeEach ->
        setupController(page, per_page, [])
        httpBackend.flush()

      it 'redirects to itself with paging params', ->
        scope.index(page, per_page)
        expect(location.path()).toBe('/')
        expect(location.search()).toEqualData({page: page, per_page: per_page})
