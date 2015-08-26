// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap
//= require dataTables/jquery.dataTables
//= require turbolinks
//= require_tree .

'use strict';

// var $ = require('jquery');
// var bootstrap = require('bootstrap');
var metismenu = require('metismenu');

// var assets = require('./assets');
// var components = require('./components');

;(function($) {

  $(document).ready(function(){
    $("#menu-toggle").click(function(e) {
      e.preventDefault();
      $("#wrapper").toggleClass("toggled");
    });

    $(".sidebar-nav").metisMenu();

    setTimeout(function(){  $(".loading-mask").fadeOut( "fast", function() {
      $(".loading-mask").hide();
    }) }, 1500);
  });

})(jQuery);

