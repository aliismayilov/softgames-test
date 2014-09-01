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

    factory.showAlbum = function(albumId) {
      return $http.get('https://picasaweb.google.com/data/feed/api/user/default/albumid/' + albumId, {
        params: {
          access_token: $rootScope.access_token,
          alt: 'json'
        }
      });
    };

    factory.listComments = function(albumId, photoId) {
      return $http.get('https://picasaweb.google.com/data/feed/api/user/default/albumid/' + albumId + '/photoid/' + photoId, {
        params: {
          access_token: $rootScope.access_token,
          alt: 'json',
          kind: 'comment'
        }
      });
    };

    return factory;
  }]).
  factory('commentFactory', ['$resource', function($resource){
    return $resource("/api/comments/:id");
  }]);
