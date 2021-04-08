$(document).on('turbolinks:load', function() {

    $( document ).ready(function() {
        $("#sidebar li").each(function() {
            var navItem = $(this);
            if (navItem.find("a").attr("href") == location.pathname) {
                navItem.find("a").addClass("active-sidebar");
                navItem.closest('ul').addClass('collapse show');
            }
        });
    });
});