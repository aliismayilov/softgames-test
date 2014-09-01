'use strict';

/* Controllers */

angular.module('picasaApp.controllers', [])
  .controller('AlbumListCtrl',
  ['$scope', 'albumFactory', function($scope, albumFactory) {
    var _initialize = function() {
      albumFactory.query().$promise.then(function(data) {
        $scope.albums = _parseAlbums(data.feed.entry);
      });
    };

    var _parseAlbums = function(entries) {
      return entries.map(function(entry) {
        return {
          thumbnail: entry.media$group.media$thumbnail[0].url,
          id: entry.gphoto$id.$t,
          title: entry.title.$t
        };
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
        $scope.comments = _parseComments(data.feed.entry);
        $scope.newComment = {
          album_id: $routeParams.albumId,
          photo_id: $routeParams.photoId
        };
      });
    };

    var _parseComments = function(entries) {
      return entries.map(function(entry) {
        return {
          author: {
            thumbnail: entry.author[0].gphoto$thumbnail.$t,
          },
          content: entry.content.$t
        };
      })
    };

    $scope.sendComment = function(comment) {
      commentFactory.save(comment, function(data) {
        $scope.newComment.content = null;
        $scope.comments.push(data.entry);
      });
    };

    _initialize();
  }]);
