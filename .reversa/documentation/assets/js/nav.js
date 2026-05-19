(function () {
  function buildNav() {
    const nav = document.querySelector('.site-nav');
    if (!nav || !window.RV_DATA || !RV_DATA.nav) return;
    const pageId = document.body.getAttribute('data-page-id');
    nav.innerHTML = RV_DATA.nav.map(function (item) {
      const cur = item.id === pageId ? ' aria-current="page"' : '';
      const href = pageId && pageId.startsWith('feature') && !item.href.startsWith('http')
        ? (item.href === 'index.html' ? '../index.html' : item.href.startsWith('features/') ? '../' + item.href : '../' + item.href)
        : item.href;
      return '<a href="' + href + '" data-page-id="' + item.id + '"' + cur + '>' + item.label + '</a>';
    }).join('');
  }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', buildNav);
  else buildNav();
})();