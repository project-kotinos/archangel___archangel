(function () {
  'use strict';

  jQuery(function() {

    function resizeBroadcast() {
      var timesRun = 0,
          interval = setInterval(function() {
            timesRun += 1;
            if (timesRun === 5) {
              clearInterval(interval);
            }
            window.dispatchEvent(new Event('resize'));
          }, 62.5);
    }

    // Add class .active to current link
    $('nav > ul.nav').find('a').each(function() {
      var currentUrl = String(window.location).split('?')[0],
          rootUrl = Archangel.route.backend.rootUrl,
          itemHref = $($(this))[0].href;

      if (currentUrl.substr(currentUrl.length - 1) === '#') {
        currentUrl = currentUrl.slice(0, -1);
      }

      // Dashboard
      if (itemHref === rootUrl && itemHref === currentUrl) {
        $(this).addClass('active');

        return;
      }

      // All other items
      if (itemHref !== rootUrl && currentUrl.lastIndexOf(itemHref, 0) === 0) {
        $(this).addClass('active');
      }
    });

    // Dropdown Menu
    $('nav > ul.nav').on('click', 'a', function(evt) {
      if ($.ajaxLoad) {
        evt.preventDefault();
      }

      if ($(this).hasClass('nav-dropdown-toggle')) {
        $(this).parent().toggleClass('open');

        resizeBroadcast();
      }
    });

    $('.sidebar-toggler').click(function(){
      $('body').toggleClass('sidebar-hidden');

      resizeBroadcast();
    });

    $('.sidebar-minimizer').click(function(){
      $('body').toggleClass('sidebar-minimized');

      resizeBroadcast();
    });

    $('.brand-minimizer').click(function(){
      $('body').toggleClass('brand-minimized');
    });

    $('.mobile-sidebar-toggler').click(function(){
      $('body').toggleClass('sidebar-mobile-show');

      resizeBroadcast();
    });

  });
}());
