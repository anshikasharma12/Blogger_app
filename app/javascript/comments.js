// app/assets/javascripts/comments.js

$(document).ready(function() {
  $('.reply-new').on('click', function() {
    var id = $(this).data('id');
    $('#'+id).toggle();
  });

  $('.cancel-reply').on('click', function(e) {
    e.preventDefault();
    var id = $(this).data('id');
    $('#'+id).hide();
  });
});
