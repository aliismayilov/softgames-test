'use strict';

/* Controllers */

angular.module('picasaApp.controllers', [])
  .controller('AlbumListCtrl',
  ['$scope', 'albumFactory', '$loader', function($scope, albumFactory, $loader) {
    var _initialize = function() {
      $loader.start();
      albumFactory.query().$promise.then(function(data) {
        $scope.albums = _parseAlbums(data.feed.entry);
        $loader.stop();
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
  ['$scope', '$routeParams', 'albumFactory', '$loader', function($scope, $routeParams, albumFactory, $loader) {
    var _initialize = function() {
      $loader.start();
      albumFactory.query({id: $routeParams.albumId}).$promise.then(function(data) {
        $scope.albumId = $routeParams.albumId;
        $scope.photos = _parsePhotos(data.feed.entry);
        $loader.stop();
      });
    };

    var _parsePhotos = function(entries) {
      return entries.slice(0, 3).map(function(entry) {
        return {
          url: entry.content.src,
          id: entry.gphoto$id.$t,
          title: entry.title.$t
        };
      });
    };

    _initialize();
  }])
  .controller('PhotoDetailCtrl',
  ['$scope', '$routeParams', 'commentFactory', '$loader', function($scope, $routeParams, commentFactory, $loader) {
    var _initialize = function() {
      $loader.start();
      commentFactory.query({album_id: $routeParams.albumId, photo_id: $routeParams.photoId}).$promise.then(function(data) {
        $scope.photoUrl = data.feed.media$group.media$content[0].url;
        $scope.comments = _parseComments(data.feed.entry || []);
        $loader.stop();
      });
      $scope.newComment = {
        album_id: $routeParams.albumId,
        photo_id: $routeParams.photoId
      };
    };

    var _parseComments = function(entries) {
      return entries.map(function(entry) {
        return {
          author: {
            thumbnail: entry.author[0].gphoto$thumbnail.$t,
          },
          content: entry.content.$t,
          url: entry.id.$t
        };
      })
    };

    $scope.sendComment = function(comment) {
      $loader.start();
      commentFactory.save(comment,
        function(data) {
          $scope.newComment.content = null;
          $scope.comments.push(data.entry);
          $scope.sending = false;
          $loader.stop();
        },
        function(error){
          $scope.errorMessage = 'Error occured: ' + error.data;
          $scope.sending = false;
          $loader.stop();
        });
    };

    $scope.deleteComment = function(comment) {
      $loader.start();
      commentFactory.delete({ url: comment.url },
        function(data) {
          var index = $scope.comments.indexOf(comment);
          $scope.comments.splice(index, 1);
          $loader.stop();
        },
        function(error){
          $scope.errorMessage = 'Error occured: ' + error.data;
          $loader.stop();
        });
    };

    _initialize();
  }]);
