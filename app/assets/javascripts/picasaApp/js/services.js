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
          alt: 'json'
        }
      });
    };

    factory.showAlbum = function(albumId) {
      return $http.get('https://picasaweb.google.com/data/feed/api/user/default/albumid/' + albumId, {
        params: {
          alt: 'json'
        }
      });
    };

    factory.listComments = function(albumId, photoId) {
      return $http.get('https://picasaweb.google.com/data/feed/api/user/default/albumid/' + albumId + '/photoid/' + photoId, {
        params: {
          alt: 'json',
          kind: 'comment'
        }
      });
    };

    return factory;
  }]).
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
