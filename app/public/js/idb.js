(function( $ ){

    $.fn.setupImage = function(){
      // $(this).each(function(){
      //   $(this).hover(function() {
      //     $(".img-side", this).fadeIn();
      //   }, function() {
      //     $(".img-side", this).fadeOut();
      //   });
      // });
    };

})(jQuery);

$(document).ready(function () {
  $(".img-box").setupImage();
  $("ul#thumb-tabs").tabs("#thumb-content", {
    effect: 'ajax',
    rotate: true
  }).slideshow();
  //$("ul#thumb-tabs").data("slideshow").play();
});
