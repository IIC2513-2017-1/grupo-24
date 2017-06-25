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
  $('#user_avatar').on('change', function(event) {
    var files = event.target.files;
    var image = files[0]
    var reader = new FileReader();
    reader.onload = function(file) {
      var img = new Image();
      img.src = file.target.result;
      if (jcrop_api !== null){
        jcrop_api.destroy()
      }
      $('.edit-image').css('height', '');
      $('.edit-image').css('width', '');
      $('.edit-image').attr('src', img.src);
      var original_width = document.getElementById("cropbox").offsetWidth;
      $('.edit-image').css('height', 'auto');
      $('.edit-image').css('width', '150px');
      var height = document.getElementById("cropbox").offsetHeight;
      var width = document.getElementById("cropbox").offsetWidth;
      ratio = original_width /  width;
      $('#cropbox').Jcrop({
        onChange: update_crop,
        onSelect: update_crop,
        setSelect: [0, 0, width, height]
        //aspectRatio: 1
      }, function(){
        jcrop_api = this;
      });
    }
    reader.readAsDataURL(image);
  function update_crop(coords) {
    $('#crop_x').val(coords.x*ratio);
    $('#crop_y').val(coords.y*ratio);
    $('#crop_w').val(coords.w*ratio);
    $('#crop_h').val(coords.h*ratio);
  }
  });
});
