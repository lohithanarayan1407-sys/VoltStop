(function () {
  var KEY = 'voltstop-theme';

  function getSaved() {
    try { return localStorage.getItem(KEY); } catch (e) { return null; }
  }

  function apply(theme) {
    if (theme === 'dark') {
      document.documentElement.setAttribute('data-theme', 'dark');
    } else {
      document.documentElement.removeAttribute('data-theme');
    }
  }

  apply(getSaved());

  document.addEventListener('DOMContentLoaded', function () {
    var btn = document.createElement('button');
    btn.type = 'button';
    btn.className = 'theme-toggle';

    function refresh() {
      var dark = document.documentElement.getAttribute('data-theme') === 'dark';
      btn.textContent = dark ? 'Switch to light' : 'Switch to dark';
    }

    btn.addEventListener('click', function () {
      var dark = document.documentElement.getAttribute('data-theme') === 'dark';
      var next = dark ? 'light' : 'dark';
      try { localStorage.setItem(KEY, next); } catch (e) {}
      apply(next);
      refresh();
    });

    refresh();
    document.body.appendChild(btn);
  });
})();