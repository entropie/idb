(function( $ ){

    $.fn.setupImage = function(){
      $(this).each(function(){
        $(this).hover(function() {
          $(".img-side", this).slideDown();
        }, function() {
          $(".img-side", this).delay(1000).slideUp();
        });
      });
    };

})(jQuery);

$(document).ready(function () {
  $(".img-box").setupImage();
});
