document.addEventListener("DOMContentLoaded", function() {
    
    
    $(document).ready(function() {
    let $win = $(window);
    let $header = $('.qz_hd.wrapper');

    $win.on('scroll', function() {
        let scrT = $win.scrollTop();
        if ($('.thispage_Main').length > 0) {
            scrT > 0 ? $header.addClass('fixed') : $header.removeClass('fixed');
        }
    });
});

});
