'use strict';

/* Controllers */

angular.module('picasaApp.controllers', [])
  .controller('AlbumsCtrl',
  ['$scope', 'picasaFactory', function($scope, picasaFactory) {
    console.log(picasaFactory.listAlbums());
  }])
  .controller('MyCtrl2', ['$scope', function($scope) {

  }]);
