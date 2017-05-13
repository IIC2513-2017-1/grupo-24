// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on('turbolinks:load page:restore', function(){
  $('#user_avatar').on('change', function(event) {
    var files = event.target.files;
    var image = files[0]
    var reader = new FileReader();
    reader.onload = function(file) {
      var img = new Image();
      img.src = file.target.result;
      $('.edit-avatar').attr('src', img.src);
    }
    reader.readAsDataURL(image);
  });

});
