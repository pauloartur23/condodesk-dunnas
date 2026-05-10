// Auto-dismiss alerts after 4s
document.querySelectorAll('.alert').forEach(function(el) {
  setTimeout(function() {
    el.style.transition = 'opacity .5s ease';
    el.style.opacity = '0';
    setTimeout(function() { el.remove(); }, 500);
  }, 4000);
});

// Active nav link highlight based on current URL
(function() {
  const path = window.location.pathname;
  document.querySelectorAll('.nav-item').forEach(function(link) {
    const href = link.getAttribute('href');
    if (href && path.startsWith(href) && href !== '/') {
      link.classList.add('active');
    }
  });
})();
