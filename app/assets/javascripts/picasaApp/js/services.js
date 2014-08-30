'use strict';

/* Services */

// Demonstrate how to register services
// In this case it is a simple value service.
angular.module('picasaApp.services', []).
  factory('picasaFactory', ['$http', function($http){
    var factory = {};

    factory.listAlbums = function() {
      $http.get('https://picasaweb.google.com/data/feed/api/user/default')
      .success(function(data) {
        return data;
      });
    };

    return factory;
  }])
