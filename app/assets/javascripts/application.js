// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require jquery.Jcrop
//= require_tree .

$(document).on("turbolinks:load", function() {
  if($('.previous_page').length>0){
    $('.previous_page').text('Anterior');
    $('.next_page').text('Siguiente');
  }
  $('.alert').fadeOut(4000);
  $('.alert').on("mouseover", function(e) {
    $(this).stop(true).fadeIn(0);
  });

  // On mouse leave, start fade again
  $('.alert').on("mouseleave", function(e) {
    $(this).fadeOut(4000);
  });
  $('#search-btn').click(function(){
    if ($('#search-input').val().length != 0){
      window.location.href='/buscar/' + $('#search-input').val();
    }
  });
  if ($('#search-input').length != 0){
    document.querySelector('#search-input').addEventListener('keypress', function (e) {
      var key = e.which || e.keyCode;
      if (key === 13 && $('#search-input').val().length != 0) { // 13 is enter
        window.location.href='/buscar/' + $('#search-input').val();
      }
    });
  }
});
