$('.delete-user-button').click(function(){
    return confirm('Are you sure you want to delete this user?');
});

$('.delete-post-button').click(function(){
    return confirm('Are you sure you want to delete this post?');
});

$('#delete_tag_btn').click(function(){
    if (confirm('Are you sure you want to delete this tag?')) {
        let tag_slug = $('#tag_slug').text()
        window.location.replace(`${window.location.href}delete`);
    };
})