'use strict';

/* Services */

// Demonstrate how to register services
// In this case it is a simple value service.
angular.module('picasaApp.services', []).
  factory('commentFactory', ['$resource', function($resource){
    return $resource('/api/comments/:id', {}, {
      query: { method:'GET', isArray: false }
    });
  }]).
  factory('albumFactory', ['$resource', function($resource){
    return $resource('/api/albums/:id', {}, {
      query: { method:'GET', isArray: false }
    });
  }]);
