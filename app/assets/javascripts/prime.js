angular.module('primeApp', [])
  .controller('PrimeController', ['$scope', function($scope) {
    var primeNumbers;
    var _initialize = function() {
      $scope.number = 13195;
      $scope.result = [];
      primeNumbers = [2, 3];
    };

    var isPrime = function(num) {
      if (num <= 3) {
        return true;
      }
      if ((num & 1) == 0) {
        return false;
      }
      var sqrt = Math.sqrt(num);
      for (var i = 3; i <= sqrt; i += 2) {
        if (num % i == 0) {
          return false;
        }
      }
      return true;
    };

    var nextPrimeAfter = function(num) {
      if (primeNumbers.indexOf(num) < primeNumbers.length - 1) {
        return primeNumbers[primeNumbers.indexOf(num) + 1];
      }
      else {
        num += 2;
        while(!isPrime(num)) {
          num += 2;
        }
        primeNumbers.push(num);
        return num;
      }
    };

    $scope.$watch('number', function(userNumber) {
      if (Number.isInteger(userNumber)) {
        var number = userNumber;
        $scope.result = [];
        for (var currentPrime = primeNumbers[0]; currentPrime <= number; currentPrime = nextPrimeAfter(currentPrime)) {
          if (isPrime(number)) {
            $scope.result.push(number);
            break;
          }
          else {
            if (number % currentPrime == 0) {
              $scope.result.push(currentPrime);
              number /= currentPrime;
            }
          }
        }
      }
      else {
        $scope.result = [];
      }
    });

    _initialize();
  }]);
