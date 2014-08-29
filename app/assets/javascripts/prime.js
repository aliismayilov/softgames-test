angular.module('primeApp', [])
  .controller('PrimeController', ['$scope', function($scope) {
    var primeNumbers;
    var _initialize = function() {
      $scope.number = 13195;
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
      if (Number.isInteger(userNumber) && userNumber.toString().length < 12 && userNumber > 1) {
        var number = userNumber;
        $scope.result = [];
        $scope.message = null;
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

      else if (!Number.isInteger(userNumber)) {
        $scope.message = 'That\'s not an integer...';
      }
      else if (userNumber.toString().length > 11) {
        $scope.message = 'JavaScript is too slow for that :-(';
      }
      else if (Number.isInteger(userNumber) && userNumber < 1) {
        $scope.message = 'It wasn\'t in the spec.';
      }
      else if (userNumber == 1) {
        $scope.message = '1 prime to rule them all...';
      }
      else {
        $scope.message = 'That\'s because of your old software...';
      }
    });

    _initialize();
  }]);
