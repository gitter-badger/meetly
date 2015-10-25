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
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//= require dataTables/extras/dataTables.colVis
//= require modal
//= require toast
//= require_tree .

var ready;
ready = function() {
  $("#menu-toggle").click(function(e) {
    e.preventDefault();
    $("#wrapper").toggleClass("toggled");
    $("#wrapper").on("animationend webkitAnimationEnd oAnimationEnd MSAnimationEnd",
      function(e){
      $.event.trigger({ type: "menuToggled" });
      $(this).off(e);
    });
  });

  $(".sidebar-nav").metisMenu();

  setTimeout(function(){  $(".loading-mask").fadeOut( "fast", function() {
    $(".loading-mask").hide();
  }) }, 1500);
};
$(document).ready(ready);
$(document).on('page:load', ready);

