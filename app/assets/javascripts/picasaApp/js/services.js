'use strict';

/* Services */

// Demonstrate how to register services
// In this case it is a simple value service.
angular.module('picasaApp.services', []).
  factory('commentFactory', ['$resource', function($resource){
    return $resource('/api/comments/:id', {}, {
      query: { method: 'GET', isArray: false },
      delete: { method: 'DELETE', params: { id: 1 } }
    });
  }]).
  factory('albumFactory', ['$resource', function($resource){
    return $resource('/api/albums/:id', {}, {
      query: { method:'GET', isArray: false }
    });
  }]).
  factory('$loader', function(){
    var factory = {};

    factory.start = function() {
      $('#loader').show();
    };

    factory.stop = function() {
      $('#loader').hide();
    };

    return factory;
  });
