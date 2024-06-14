document.addEventListener('DOMContentLoaded', function() {
  document.querySelectorAll('.reply-link').forEach(link => {
    link.addEventListener('click', function(event) {
      event.preventDefault();
      let commentId = this.getAttribute('data-comment-id');
      let replyFormContainer = document.getElementById(`reply-form-container-${commentId}`);

      if (replyFormContainer.style.display === 'none' || replyFormContainer.innerHTML.trim() === '') {
        fetch(`/posts/${commentId}/comments/${commentId}/replies/new`, {
          headers: {
            'X-Requested-With': 'XMLHttpRequest'
          }
        })
        .then(response => response.text())
        .then(html => {
          replyFormContainer.innerHTML = html;
          replyFormContainer.style.display = 'block';
        });
      } else {
        replyFormContainer.style.display = 'none';
      }
    });
  });
});
