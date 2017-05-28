// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
var slideIndex = 1;

function plusSlides(n) {
  showSlides(slideIndex += n);
}

function currentSlide(n) {
  showSlides(slideIndex = n);
}

function showSlides(n) {
  var i;
  var slides = document.getElementsByClassName("mySlides");
  var dots = document.getElementsByClassName("dot");
  if (n > slides.length) {slideIndex = 1}
  if (n < 1) {slideIndex = slides.length}
  for (i = 0; i < slides.length; i++) {
      slides[i].style.display = "none";
  }
  for (i = 0; i < dots.length; i++) {
      dots[i].className = dots[i].className.replace(" active", "");
  }
  slides[slideIndex-1].style.display = "block";
  dots[slideIndex-1].className += " active";
}

$(document).on("turbolinks:load", function() {
  if($('.slideshow-container').length){
    showSlides(slideIndex);
  }
  $('.category-btn').on('click', function(){
    category = $(this).data('');
    if ($(this).hasClass('active')){
      $(this).css('background-color', 'white')
      $(this).css('color', $(this).data('color') )
      $(this).removeClass('active')
    }else{
      $(this).css('background-color', $(this).data('color'))
      $(this).css('color', 'white')
      $(this).addClass('active')
    }
    var arr = []
    $('.category-btn').each(function(){
      if(!$(this).hasClass('active')){
        arr.push($(this).attr('value'));
      }
    });
   $.each($('[id*="category_"]'), function(i, hidden) {
     $(this).val(arr);
    });
  });
});
