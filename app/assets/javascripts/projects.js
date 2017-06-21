// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function move(percentege) {
    var elem = document.getElementById("myBar");
    var width = 0;
    var id = setInterval(frame, 10);
    function frame() {
        if (width >= 100 || width == percentege) {
            clearInterval(id);
        } else {
            width++;
            elem.style.width = width + '%';
        }
    }
}

$(document).on("turbolinks:load", function() {
  move($('#myBar').data('percentage'));
});

$(document).on('turbolinks:load page:restore', function(){
  $('#project_image').on('change', function(event) {
    var files = event.target.files;
    var image = files[0]
    var reader = new FileReader();
    reader.onload = function(file) {
      var img = new Image();
      img.src = file.target.result;
      $('.edit-image').attr('src', img.src);
    }
    reader.readAsDataURL(image);
  });
});
