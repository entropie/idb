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

$.tools.tabs.addEffect("myslide", function(i, done) {
  this.getPanes().hide();

  this.getPanes().eq(i).slideDown("slow", function()  {
    $(".img-box img", this).each(fancyBoxAni);
    done.call();
  });
});

function fancyBoxAni(){
  var img = $(this);
  $(img).fancybox({
    href: $(this).attr('data-org'),
    transitionIn: 'elastic',
    transitionOut: 'elastic'
  });
}



$(document).ready(function () {
  $("#preload a").preload({
    threshold: 3
    //onFinish: function(){ alert("preloaded");}
  });

  $(".img-box").setupImage();
  $("#thumb-tabs").tabs("#thumb-content > div", {
    effect: 'myslide',
    fadeInSpeed: 1000,
    fadeOutSpeed: 0,
    rotate: true,
    onBeforeClick: function(event, i) {
      var pane = this.getPanes().eq(i);
      if (pane.is(":empty")) {
        pane.load(this.getTabs().eq(i).attr("href"));
      }
    }
  }).slideshow({clickable: false});
  //$("ul#thumb-tabs").data("slideshow").play();

  $(".img-box img").each(fancyBoxAni);
});
