angular.module('primeApp', [])
  .controller('PrimeController', ['$scope', function($scope) {
    var _initialize = function() {
      $scope.number = 13195;
    }

    $scope.$watch('number', function(number) {
      $scope.result = number + 1;
    });

    _initialize();
  }]);
