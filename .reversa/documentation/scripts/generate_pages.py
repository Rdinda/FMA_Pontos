#!/usr/bin/env python3
"""Gera páginas HTML do mini-site Reversa Docs (offline-first)."""
import json
import hashlib
import re
from pathlib import Path
from datetime import datetime, timezone

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "assets" / "data"
FEATURES_DIR = ROOT / "features"
SDD = Path(__file__).resolve().parents[3] / "_reversa_sdd"

COMPLEXITY_SCORE = {"low": 1, "medium": 2, "high": 3}
SOBER = {
    "bg": "#0f1114",
    "panel": "#1a1d23",
    "text": "#e8eaed",
    "muted": "#9aa0a6",
    "accent": "#5c7cfa",
    "border": "#2d323b",
}


def load_json(name):
    p = DATA / name
    return json.loads(p.read_text(encoding="utf-8")) if p.exists() else {}


def sha256_file(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def page_shell(title, page_id, category, producer, head_extra, payload, scripts_extra=""):
    ts = datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")
    return f"""<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="reversa-category" content="{category}">
  <meta name="reversa-producer-agent" content="{producer}">
  <meta name="reversa-template" content="{page_id}">
  <title>{title} | FMA Pontos Docs</title>
  <link rel="stylesheet" href="assets/css/docs.css">
  {head_extra}
</head>
<body data-page-id="{page_id}" data-visual-style="sober">
  <header class="site-header">
    <a href="index.html" class="seal-link" aria-label="Início">
      <!-- MINI_SEAL_SVG -->
      <span class="seal-placeholder"></span>
    </a>
    <nav class="site-nav" aria-label="Principal">
      <!-- NAV_LINKS -->
    </nav>
  </header>
  <main class="site-main">
    <h1>{title}</h1>
    {payload}
  </main>
  <footer class="site-footer">
    <small>Gerado pelo Reversa Docs em {ts}</small>
  </footer>
  <script src="assets/js/data.js"></script>
  <script src="assets/js/nav.js"></script>
  {scripts_extra}
</body>
</html>
"""


def gen_arquitetura():
    payload = """
    <p class="lead">Code City: cada módulo é um prédio. Arraste para orbitar, scroll para zoom.</p>
    <div class="viz-wrap"><canvas id="city-canvas" width="1200" height="640"></canvas></div>
    """
    head = """
  <script src="assets/vendor/three.min.js"></script>
  <script src="assets/vendor/OrbitControls.js"></script>
    """
    scripts = """
  <script>
  (function(){
    const mods = (window.RV_DATA && window.RV_DATA.modules && window.RV_DATA.modules.modules) || [];
    const edges = (window.RV_DATA && window.RV_DATA.deps && window.RV_DATA.deps.edges) || [];
    const canvas = document.getElementById('city-canvas');
    if (!window.THREE || !mods.length) {
      canvas.parentElement.innerHTML = '<p class="warn">Biblioteca Three.js ou dados indisponíveis.</p>';
      return;
    }
    const scene = new THREE.Scene();
    scene.background = new THREE.Color(0x0f1114);
    const camera = new THREE.PerspectiveCamera(55, canvas.clientWidth / 640, 0.1, 2000);
    camera.position.set(40, 35, 50);
    const renderer = new THREE.WebGLRenderer({ canvas, antialias: true });
    renderer.setSize(canvas.clientWidth, 640);
    const light = new THREE.DirectionalLight(0xffffff, 0.9);
    light.position.set(30, 50, 20);
    scene.add(light);
    scene.add(new THREE.AmbientLight(0x404040, 0.6));
    const maxLoc = Math.max(...mods.map(m => m.loc || 1));
    const grid = Math.ceil(Math.sqrt(mods.length));
    mods.forEach((m, i) => {
      const h = 2 + (m.loc / maxLoc) * 18;
      const cs = {low:1, medium:2, high:3};
      const w = 2 + (cs[m.complexity] || 1) * 1.2;
      const geo = new THREE.BoxGeometry(w, h, w);
      const col = m.complexity === 'high' ? 0xe74c3c : m.complexity === 'medium' ? 0xf39c12 : 0x5c7cfa;
      const mesh = new THREE.Mesh(geo, new THREE.MeshStandardMaterial({ color: col }));
      mesh.position.set((i % grid) * 6 - grid * 3, h / 2, Math.floor(i / grid) * 6 - grid * 3);
      mesh.userData = m;
      scene.add(mesh);
    });
    const controls = new THREE.OrbitControls(camera, renderer.domElement);
    controls.enableDamping = true;
    function animate(){ requestAnimationFrame(animate); controls.update(); renderer.render(scene, camera); }
    animate();
  })();
  </script>
    """
    html = page_shell("Arquitetura 3D", "arquitetura", "diagram", "reversa-docs-mapper", head, payload, scripts)
    (ROOT / "arquitetura.html").write_text(html, encoding="utf-8")


def gen_modulos():
    payload = """
    <p class="lead">Grafo force-directed de dependências entre módulos.</p>
    <div id="graph" class="viz-wrap"></div>
    """
    head = '<script src="assets/vendor/d3.v7.min.js"></script>'
    scripts = """
  <script>
  (function(){
    const mods = (window.RV_DATA.modules && window.RV_DATA.modules.modules) || [];
    const edges = (window.RV_DATA.deps && window.RV_DATA.deps.edges) || [];
    const el = document.getElementById('graph');
    if (!window.d3 || !mods.length) { el.innerHTML = '<p class="warn">D3 ou dados indisponíveis.</p>'; return; }
    const w = el.clientWidth || 1100, h = 560;
    const nodes = mods.map(m => ({ id: m.id, name: m.name, loc: m.loc }));
    const links = edges.map(e => ({ source: e.source, target: e.target }));
    const svg = d3.select(el).append('svg').attr('width', w).attr('height', h);
    const sim = d3.forceSimulation(nodes)
      .force('link', d3.forceLink(links).id(d => d.id).distance(90))
      .force('charge', d3.forceManyBody().strength(-280))
      .force('center', d3.forceCenter(w/2, h/2));
    const link = svg.append('g').selectAll('line').data(links).join('line').attr('stroke', '#5c7cfa').attr('stroke-opacity', 0.5);
    const node = svg.append('g').selectAll('circle').data(nodes).join('circle')
      .attr('r', d => 6 + Math.sqrt(d.loc || 1) / 8)
      .attr('fill', '#e8eaed');
    const label = svg.append('g').selectAll('text').data(nodes).join('text')
      .text(d => d.id).attr('font-size', 10).attr('fill', '#9aa0a6');
    sim.on('tick', () => {
      link.attr('x1', d => d.source.x).attr('y1', d => d.source.y).attr('x2', d => d.target.x).attr('y2', d => d.target.y);
      node.attr('cx', d => d.x).attr('cy', d => d.y);
      label.attr('x', d => d.x + 8).attr('y', d => d.y + 4);
    });
  })();
  </script>
    """
    (ROOT / "modulos.html").write_text(page_shell("Mapa de Módulos", "modulos", "diagram", "reversa-docs-mapper", head, payload, scripts), encoding="utf-8")


def gen_topologia():
    payload = """
    <p class="lead">Visão side-by-side: legado atual vs alvo documentado nas specs.</p>
    <div class="topo-grid">
      <article class="card"><h2>Legado (atual)</h2>
        <ul>
          <li>Flutter monolito + Provider</li>
          <li>SQLite offline-first + Supabase sync</li>
          <li>RBAC em user_roles + RLS</li>
          <li>Sem API custom além do Supabase</li>
        </ul>
      </article>
      <article class="card"><h2>Alvo (specs Reversa)</h2>
        <ul>
          <li>Merge por campo em conflitos de sync</li>
          <li>is_active bloqueia login</li>
          <li>Soft delete unificado</li>
          <li>Política LGPD enxuta + versionamento</li>
        </ul>
      </article>
    </div>
    """
    (ROOT / "topologia.html").write_text(page_shell("Topologia", "topologia", "diagram", "reversa-docs-mapper", "", payload), encoding="utf-8")


def gen_metricas():
    payload = """
    <p class="lead">Dashboard de LOC, complexidade e dependências.</p>
    <div class="charts-grid">
      <div id="chart-treemap" class="chart-box"></div>
      <div id="chart-bars" class="chart-box"></div>
      <div id="chart-sankey" class="chart-box chart-wide"></div>
    </div>
    """
    head = """
  <script src="assets/vendor/highcharts.js"></script>
  <script src="assets/vendor/highcharts-treemap.js"></script>
  <script src="assets/vendor/highcharts-sankey.js"></script>
    """
    scripts = """
  <script>
  (function(){
    const M = window.RV_DATA.metrics || {};
    if (!window.Highcharts) {
      document.querySelector('.charts-grid').innerHTML = '<p class="warn">Highcharts indisponível. Rode o Publisher com rede.</p>';
      return;
    }
  Highcharts.setOptions({ chart: { backgroundColor: '#1a1d23' }, title: { style: { color: '#e8eaed' } } });
  if (M.treemap_loc_by_folder) {
    Highcharts.chart('chart-treemap', {
      chart: { type: 'treemap' },
      title: { text: 'LOC por pasta' },
      series: [{ type: 'treemap', layoutAlgorithm: 'squarified', data: M.treemap_loc_by_folder.map(r => ({ name: r.folder, value: r.loc })) }]
    });
  }
  if (M.top_complexity) {
    Highcharts.chart('chart-bars', {
      chart: { type: 'bar' },
      title: { text: 'Top complexidade' },
      xAxis: { categories: M.top_complexity.map(x => x.module), labels: { style: { color: '#9aa0a6' } } },
      yAxis: { title: { text: 'LOC' }, labels: { style: { color: '#9aa0a6' } } },
      series: [{ name: 'LOC', data: M.top_complexity.map(x => x.loc), color: '#5c7cfa' }]
    });
  }
  if (M.sankey_nodes && M.sankey_links) {
    Highcharts.chart('chart-sankey', {
      title: { text: 'Dependências entre módulos' },
      series: [{ keys: ['from','to','weight'], type: 'sankey', data: M.sankey_links.map(l => [l.from, l.to, 1]), nodes: M.sankey_nodes.map(n => ({ id: n.id, name: n.id })) }]
    });
  }
  })();
  </script>
    """
    (ROOT / "metricas.html").write_text(page_shell("Métricas", "metricas", "metrics", "reversa-docs-analyst", head, payload, scripts), encoding="utf-8")


def gen_glossario():
    payload = """
    <p class="lead">Conceitos do domínio FMA Pontos.</p>
    <input type="search" id="gloss-search" placeholder="Buscar termo..." class="search-input">
    <div id="gloss-list" class="gloss-list"></div>
    """
    scripts = """
  <script>
  (function(){
    const items = (window.RV_DATA.glossary && window.RV_DATA.glossary.terms) || [];
    const list = document.getElementById('gloss-list');
    const input = document.getElementById('gloss-search');
    function render(q) {
      list.innerHTML = '';
      const f = q ? items.filter(t => t.term.toLowerCase().includes(q) || t.definition.toLowerCase().includes(q)) : items;
      f.forEach(t => {
        const d = document.createElement('details');
        d.className = 'gloss-item';
        d.innerHTML = '<summary>' + t.term + '</summary><p>' + t.definition + '</p>';
        list.appendChild(d);
      });
    }
    input.addEventListener('input', () => render(input.value.toLowerCase()));
    render('');
  })();
  </script>
    """
    (ROOT / "glossario.html").write_text(page_shell("Glossário", "glossario", "narrative", "reversa-docs-storyteller", "", payload, scripts), encoding="utf-8")


def gen_deck():
    slides = [
        ("FMA Pontos", "App Flutter offline-first para pontos e letras musicais/litúrgicas."),
        ("Stack", "Flutter + SQLite + Supabase + Google OAuth + GitHub Releases."),
        ("Módulos", "11 módulos mapeados: screens e services concentram a complexidade."),
        ("Sync", "PUSH/PULL incremental com soft delete; merge por campo é regra alvo."),
        ("Segurança", "RBAC user/moderator/admin; apenas logados escrevem no servidor."),
        ("Próximo passo", "Explore features/, métricas e arquitetura 3D."),
    ]
    slides_html = "".join(
        f'<section class="deck-slide{" active" if i==0 else ""}" data-i="{i}"><h2>{t}</h2><p>{b}</p></section>'
        for i, (t, b) in enumerate(slides)
    )
    payload = f"""
    <div class="deck-viewer">{slides_html}</div>
    <div class="deck-controls">
      <button type="button" id="deck-prev">Anterior</button>
      <span id="deck-indicator">1 / {len(slides)}</span>
      <button type="button" id="deck-next">Próximo</button>
    </div>
    """
    scripts = """
  <script>
  (function(){
    const slides = document.querySelectorAll('.deck-slide');
    let i = 0;
    function show(n) {
      slides.forEach((s,j) => s.classList.toggle('active', j === n));
      document.getElementById('deck-indicator').textContent = (n+1) + ' / ' + slides.length;
    }
    document.getElementById('deck-prev').onclick = () => { i = Math.max(0, i-1); show(i); };
    document.getElementById('deck-next').onclick = () => { i = Math.min(slides.length-1, i+1); show(i); };
    show(0);
  })();
  </script>
    """
    (ROOT / "deck.html").write_text(page_shell("Deck", "deck", "narrative", "reversa-docs-storyteller", "", payload, scripts), encoding="utf-8")


def gen_feature(f):
    fid = f["id"]
    req_path = SDD / fid / "requirements.md"
    body = "<p>Spec não encontrada.</p>"
    if req_path.exists():
        text = req_path.read_text(encoding="utf-8")
        m = re.search(r"## Visão Geral\s*\n+([\s\S]*?)(?=\n## )", text)
        body = "<div class='spec-body'>" + (
            "<p>" + re.sub(r"🟢|🟡|🔴|\*\*CONFIRMADO\*\*|\*\*INFERIDO\*\*|\*\*LACUNA\*\*", "", m.group(1).strip()[:1200]) + "</p>"
            if m else "<p>" + f.get("summary", "") + "</p>"
        ) + "</div>"
    payload = f"""
    <p class="lead">{f.get('summary','')}</p>
    {body}
    <p><a href="../glossario.html">Glossário</a> · <a href="../modulos.html">Módulos</a></p>
    """
    html = page_shell(f.get("title", fid), f"feature-{fid}", "feature", "reversa-docs-storyteller", "", payload)
    html = html.replace('href="assets/', 'href="../assets/').replace('href="index.html"', 'href="../index.html"')
    html = html.replace('data-page-id="feature-', 'data-page-id="features-')
    (FEATURES_DIR / f"{fid}.html").write_text(html, encoding="utf-8")


def gen_index():
    feats = load_json("features-index.json").get("features", [])
    feat_links = "".join(
        f'<li><a href="features/{f["id"]}.html">{f["title"]}</a></li>' for f in feats
    )
    payload = f"""
    <section class="hero">
      <div class="hero-seal"><!-- HERO_SEAL_SVG --></div>
      <h1>FMA Pontos</h1>
      <p class="lead">Documentação interativa gerada pelo Reversa. Perfil: novo desenvolvedor.</p>
    </section>
    <section class="index-grid">
      <article class="card"><h2>Explorar</h2><ul>
        <li><a href="arquitetura.html">Arquitetura 3D</a></li>
        <li><a href="modulos.html">Mapa de módulos</a></li>
        <li><a href="metricas.html">Métricas</a></li>
        <li><a href="topologia.html">Topologia</a></li>
      </ul></article>
      <article class="card"><h2>Aprender</h2><ul>
        <li><a href="deck.html">Deck rápido</a></li>
        <li><a href="glossario.html">Glossário</a></li>
      </ul></article>
      <article class="card"><h2>Features ({len(feats)})</h2><ul>{feat_links}</ul></article>
    </section>
    """
    html = page_shell("Visão geral", "index", "hub", "reversa-docs-publisher", "", payload)
    html = html.replace("<h1>Visão geral</h1>", "", 1)
    (ROOT / "index.html").write_text(html, encoding="utf-8")


def gen_css():
    css = """
:root {
  --bg: #0f1114; --panel: #1a1d23; --text: #e8eaed; --muted: #9aa0a6;
  --accent: #5c7cfa; --border: #2d323b;
}
* { box-sizing: border-box; }
body { margin: 0; font-family: system-ui, Segoe UI, sans-serif; background: var(--bg); color: var(--text); line-height: 1.5; }
.site-header { display: flex; align-items: center; gap: 1rem; padding: 0.75rem 1.25rem; border-bottom: 1px solid var(--border); background: var(--panel); flex-wrap: wrap; }
.site-nav { display: flex; flex-wrap: wrap; gap: 0.5rem 1rem; }
.site-nav a { color: var(--muted); text-decoration: none; font-size: 0.9rem; }
.site-nav a[aria-current="page"] { color: var(--accent); font-weight: 600; }
.site-main { max-width: 1200px; margin: 0 auto; padding: 1.5rem; }
.lead { color: var(--muted); font-size: 1.05rem; }
.card { background: var(--panel); border: 1px solid var(--border); border-radius: 8px; padding: 1rem 1.25rem; margin-bottom: 1rem; }
.viz-wrap, #graph, #city-canvas { width: 100%; max-width: 100%; background: var(--panel); border-radius: 8px; border: 1px solid var(--border); }
.charts-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; }
.chart-box { min-height: 320px; background: var(--panel); border-radius: 8px; border: 1px solid var(--border); }
.chart-wide { grid-column: 1 / -1; min-height: 380px; }
.topo-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; }
.search-input { width: 100%; max-width: 400px; padding: 0.5rem; margin-bottom: 1rem; background: var(--panel); border: 1px solid var(--border); color: var(--text); border-radius: 6px; }
.gloss-item { margin-bottom: 0.5rem; }
.deck-slide { display: none; min-height: 280px; }
.deck-slide.active { display: block; }
.deck-controls { margin-top: 1rem; display: flex; gap: 1rem; align-items: center; }
.hero { text-align: center; padding: 2rem 0; }
.index-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(260px, 1fr)); gap: 1rem; }
.warn { color: #f39c12; }
.site-footer { text-align: center; padding: 2rem; color: var(--muted); font-size: 0.85rem; }
@media (max-width: 768px) { .charts-grid, .topo-grid { grid-template-columns: 1fr; } }
"""
    (ROOT / "assets/css/docs.css").write_text(css.strip(), encoding="utf-8")


def gen_nav_js():
    js = """
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
"""
    (ROOT / "assets/js/nav.js").write_text(js.strip(), encoding="utf-8")


def gen_seals(seed_hash):
    short = seed_hash.replace("sha256:", "")[:8]
    svg = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" width="64" height="64">
  <rect width="64" height="64" fill="#1a1d23"/>
  <circle cx="32" cy="32" r="24" fill="none" stroke="#5c7cfa" stroke-width="2"/>
  <text x="32" y="36" text-anchor="middle" fill="#e8eaed" font-size="10" font-family="monospace">{short}</text>
</svg>'''
    mini = svg.replace('width="64" height="64"', 'width="32" height="32"').replace('viewBox="0 0 64 64"', 'viewBox="0 0 64 64" width="32" height="32"')
    (ROOT / "assets/img/seal.svg").write_text(svg, encoding="utf-8")
    (ROOT / "assets/img/seal-mini.svg").write_text(mini, encoding="utf-8")
    return svg, mini


def gen_data_js(config, pages, seal_svg, seal_mini):
    blobs = {}
    for name in ["modules", "deps", "metrics", "glossary", "featuresIndex", "soul"]:
        fname = {"featuresIndex": "features-index.json", "glossary": "glossary.json"}.get(name, f"{name}.json" if name != "featuresIndex" else "features-index.json")
        key_file = {"modules": "modules.json", "deps": "deps.json", "metrics": "metrics.json", "glossary": "glossary.json", "featuresIndex": "features-index.json", "soul": "soul.json"}[name]
        blobs[name] = load_json(key_file)
    nav_labels = {
        "index": ("index.html", "Visão geral"),
        "arquitetura": ("arquitetura.html", "Arquitetura 3D"),
        "modulos": ("modulos.html", "Módulos"),
        "topologia": ("topologia.html", "Topologia"),
        "metricas": ("metricas.html", "Métricas"),
        "glossario": ("glossario.html", "Glossário"),
        "deck": ("deck.html", "Deck"),
    }
    nav = [{"id": k, "href": v[0], "label": v[1]} for k, v in nav_labels.items() if (ROOT / v[0]).exists()]
    seed = config.get("seed", {}).get("hash", "")
    js = "window.RV_DATA = " + json.dumps({
        **blobs,
        "sealSvg": seal_svg,
        "sealMiniSvg": seal_mini,
        "seedShort": seed.replace("sha256:", "")[:8],
        "nav": nav,
        "config": config.get("interview", {}),
    }, ensure_ascii=False) + ";\n"
    (ROOT / "assets/js/data.js").write_text(js, encoding="utf-8")


def patch_seals_and_nav():
    seal_mini = (ROOT / "assets/img/seal-mini.svg").read_text(encoding="utf-8")
    for html_path in ROOT.glob("**/*.html"):
        text = html_path.read_text(encoding="utf-8")
        if "<!-- MINI_SEAL_SVG -->" in text:
            text = text.replace("<!-- MINI_SEAL_SVG -->", seal_mini)
            text = text.replace('<span class="seal-placeholder"></span>', "")
        if "<!-- HERO_SEAL_SVG -->" in text:
            hero = (ROOT / "assets/img/seal.svg").read_text(encoding="utf-8")
            text = text.replace("<!-- HERO_SEAL_SVG -->", hero)
        html_path.write_text(text, encoding="utf-8")


def main():
    config = json.loads((ROOT / ".config.json").read_text(encoding="utf-8"))
    gen_css()
    gen_nav_js()
    seal, mini = gen_seals(config["seed"]["hash"])
    gen_arquitetura()
    gen_modulos()
    gen_topologia()
    gen_metricas()
    gen_glossario()
    gen_deck()
    for f in load_json("features-index.json").get("features", []):
        gen_feature(f)
    gen_index()
    pages = [p.name for p in ROOT.glob("*.html")] + [f"features/{p.name}" for p in FEATURES_DIR.glob("*.html")]
    gen_data_js(config, pages, seal, mini)
    patch_seals_and_nav()
    state = {
        "schemaVersion": 1,
        "lastCheckpoint": datetime.now(timezone.utc).isoformat(),
        "completedAgents": ["reversa-docs-mapper", "reversa-docs-analyst", "reversa-docs-storyteller", "reversa-docs-publisher"],
        "pendingAgents": [],
        "pagesGenerated": pages,
        "pagesOmitted": config.get("pagesOmitted", []),
        "cdnFallbackUsed": True,
        "vendorMissing": [],
        "pipelineDurationMs": 0,
        "smokeTestFailed": False,
        "smokeTestErrors": [],
    }
    (ROOT / ".state.json").write_text(json.dumps(state, indent=2), encoding="utf-8")
    print("Generated", len(pages), "pages")


if __name__ == "__main__":
    main()

