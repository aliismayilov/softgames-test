'use strict';

/* Controllers */

angular.module('picasaApp.controllers', [])
  .controller('AlbumsCtrl',
  ['$scope', 'picasaFactory', function($scope, picasaFactory) {
    var _initialize = function() {
      picasaFactory.listAlbums().success(function (data) {
        $scope.albums = data.feed.entry;
      });
    };

    _initialize();
  }])
  .controller('MyCtrl2', ['$scope', function($scope) {

  }]);
