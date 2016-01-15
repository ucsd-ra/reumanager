var intro = $('#splash-intro');
var content = $("#splash-content");
var intro_content = $("#splash-intro .container");

var splash_footer = $("#splash-footer");
var content_header = $("#content-header");
var navbar = $(".navbar-transparent");

(function($) {
    /* scroll events */
    intro.on("mousewheel", function(e) {
        if (e.deltaY <= 0 && $(window).height() >= 740) {
            show_content();
        }
    });


    /* click events */
    splash_footer.on("click", function() {
        if ($(window).height() >= 740)
            show_content();
    });

    content_header.on("click", function() {
        show_splash();
    });


    function show_splash() {
        intro.animate({
            height: '100%'
        }, 500);
        intro_content.css({
            "transition": "all .5s ease",
            "transform": "translateY(0px)"
        });
        navbar.addClass("navbar-transparent");
    }

    function show_content() {
        intro.animate({
            height: 0
        }, 500);
        intro_content.css({
            "transition": "all .5s ease",
            "transform": "translateY(-800px)"
        });
        setTimeout(function() {
            navbar.removeClass('navbar-transparent');
        }, 400);
    }
})(jQuery);