'use strict';

/* Controllers */

angular.module('picasaApp.controllers', [])
  .controller('AlbumListCtrl',
  ['$scope', 'picasaFactory', function($scope, picasaFactory) {
    var _initialize = function() {
      picasaFactory.listAlbums().success(function(data) {
        $scope.albums = data.feed.entry;
      });
    };

    _initialize();
  }])
  .controller('AlbumDetailCtrl',
  ['$scope', '$routeParams', 'picasaFactory', function($scope, $routeParams, picasaFactory) {
    var _initialize = function() {
      picasaFactory.showAlbum($routeParams.albumId).success(function(data) {
        $scope.albumId = $routeParams.albumId;
        $scope.photos = data.feed.entry;
      });
    };

    _initialize();
  }])
  .controller('PhotoDetailCtrl',
  ['$scope', '$routeParams', 'picasaFactory', 'commentFactory', function($scope, $routeParams, picasaFactory, commentFactory) {
    var _initialize = function() {
      picasaFactory.listComments($routeParams.albumId, $routeParams.photoId).success(function(data) {
        $scope.photoUrl = data.feed.media$group.media$content[0].url;
        $scope.comments = data.feed.entry;
        $scope.newComment = {
          album_id: $routeParams.albumId,
          photo_id: $routeParams.photoId
        };
      });
    };

    $scope.sendComment = function(comment) {
      commentFactory.save(comment).success(function(data) {
        $scope.comments.push(data);
      });
    };

    _initialize();
  }]);
