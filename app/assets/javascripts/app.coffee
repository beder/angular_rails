angular_rails = angular.module('angular_rails', [
  'templates',
  'ngRoute',
  'ngResource',
  'controllers'
])

angular_rails.config([ '$routeProvider',
  ($routeProvider)->
    $routeProvider
      .when('/',
        templateUrl: "index.html"
        controller: 'PromoterNetworksController'
      )
])

controllers = angular.module('controllers',[])

controllers.controller("PromoterNetworksController", [ '$scope', '$routeParams', '$location', '$resource',
  ($scope, $routeParams, $location, $resource)->
    $scope.index = (page, per_page)-> $location.path('/').search('page', page).search('per_page', per_page)
    PromoterNetwork = $resource('/promoter_networks/:promoterNetworkId', { promoterNetworkId: "@id", format: 'json' })

    PromoterNetwork.query(page: $routeParams.page, per_page: $routeParams.per_page, (results)-> $scope.promoter_networks = results)
])