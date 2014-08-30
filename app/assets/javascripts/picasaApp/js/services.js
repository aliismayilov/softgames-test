'use strict';

/* Services */

// Demonstrate how to register services
// In this case it is a simple value service.
angular.module('picasaApp.services', []).
  factory('picasaFactory',
  ['$http', '$rootScope', function($http, $rootScope){
    var factory = {};

    factory.listAlbums = function() {
      return $http.get('https://picasaweb.google.com/data/feed/api/user/default', {
        params: {
          access_token: $rootScope.access_token,
          alt: 'json'
        }
      });
    };

    return factory;
  }]);
