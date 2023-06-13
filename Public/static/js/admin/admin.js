$('.delete-user-button').click(function(){
    return confirm('Are you sure you want to delete this user?');
});

$('.delete-post-button').click(function(){
    return confirm('Are you sure you want to delete this post?');
});

$('#delete_tag_btn').click(function(){
    if (confirm('Are you sure you want to delete this tag?')) {
        window.location.replace(`${window.location.href}delete`);
    };
})

$('#gh-mobile-nav-bar-more').click(function(){
    $('.gh-viewport').addClass('mobile-menu-expanded')
})

$('#gh-content-cover').click(function(){
    $('.gh-viewport').removeClass('mobile-menu-expanded')
})

$('.gh-alerts').click(function(){
    $('.gh-alerts').addClass('hidden')
})

$('#admin-user-account').click(function(){
    if (confirm('Are you sure you want to logout?')) {
        let siteURL = $('#site_url').text()
        window.location.replace(`${siteURL}/steampress/logout/`);
    };
})