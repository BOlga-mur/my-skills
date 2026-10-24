/* SvetLamp theme: hero sizing, colour temperature, socket picker, catalog panel, scroll reveal. */

/* ---------- Hero fits the first screen ---------- */
(function () {
  const hero = document.querySelector('.sl .hero');
  if (!hero) return;
  const root = document.documentElement;
  function fit() {
    const above = Math.round(hero.getBoundingClientRect().top + window.scrollY);
    root.style.setProperty('--above', above + 'px');
    // The height is also set on the element itself: the shop's other styles cannot override it there
    hero.style.height = (window.innerHeight - above) + 'px';
  }
  fit();
  // Phones resize the window while the address bar hides on scroll; refit only on a real change of size
  let lastW = window.innerWidth, lastH = window.innerHeight;
  window.addEventListener('resize', () => {
    if (window.innerWidth === lastW && Math.abs(window.innerHeight - lastH) < 120) return;
    lastW = window.innerWidth; lastH = window.innerHeight;
    fit();
  });
  if (document.fonts) document.fonts.ready.then(fit);
  if ('ResizeObserver' in window) new ResizeObserver(fit).observe(document.querySelector('.directions'));
})();

/* ---------- Colour temperature ---------- */
(function () {
  const input = document.getElementById('kelvin');
  if (!input) return;
  const out = document.getElementById('kval');
  const nameEl = document.getElementById('kname');
  const note = document.getElementById('knote');
  const ticks = document.querySelectorAll('.ticks button');
  const root = document.documentElement;
  const modes = [
    { max: 3450, name: 'Тёплый', text: 'Как у лампы накаливания. Для спальни и гостиной по вечерам.' },
    { max: 5000, name: 'Нейтральный', text: 'Белый без желтизны. Кухня, прихожая, рабочий стол.' },
    { max: 6600, name: 'Холодный белый', text: 'Похож на свет пасмурного дня. Мастерская, гараж, кладовая.' }
  ];
  // Light colour as people see it on a white wall: amber at 2700K, plain white through the neutral range, bluish past 5000K
  const stops = [[2700, [255, 170, 92]], [3500, [255, 218, 172]], [4000, [255, 236, 214]], [5000, [255, 252, 246]], [6500, [214, 228, 255]]];
  function k2rgb(k) {
    let i = 0;
    while (i < stops.length - 2 && k > stops[i + 1][0]) i++;
    const [k0, c0] = stops[i], [k1, c1] = stops[i + 1];
    const t = Math.min(1, Math.max(0, (k - k0) / (k1 - k0)));
    const c = c0.map((v, j) => Math.round(v + (c1[j] - v) * t));
    return `rgb(${c[0]}, ${c[1]}, ${c[2]})`;
  }
  function set(k) {
    k = Number(k);
    root.style.setProperty('--glow', k2rgb(k));
    out.textContent = k + ' K';
    const m = modes.find(x => k <= x.max);
    nameEl.textContent = m.name;
    note.textContent = m.text;
    input.setAttribute('aria-valuetext', k + ' кельвинов, ' + m.name.toLowerCase() + ' свет');
    ticks.forEach(b => b.classList.toggle('on', Math.abs(Number(b.dataset.k) - k) < 150));
  }
  input.addEventListener('input', e => set(e.target.value));
  ticks.forEach(b => b.addEventListener('click', () => {
    const from = Number(input.value), to = Number(b.dataset.k);
    const reduce = matchMedia('(prefers-reduced-motion: reduce)').matches;
    if (reduce) { input.value = to; set(to); return; }
    const t0 = performance.now(), dur = 420;
    cancelAnimationFrame(input._raf);
    (function step(now) {
      const p = Math.min(1, (now - t0) / dur), e = 1 - Math.pow(1 - p, 3);
      const v = Math.round((from + (to - from) * e) / 50) * 50;
      input.value = v; set(v);
      if (p < 1) input._raf = requestAnimationFrame(step);
    })(t0);
  }));
  input.addEventListener('pointerdown', () => cancelAnimationFrame(input._raf));
  set(input.value);
})();

/* ---------- Sockets ---------- */
(function () {
  const S = 'fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"';
  const glass = (d) => `<path d="${d}" ${S}/>`;
  const thread = (x, y, w, n, step) => Array.from({ length: n }, (_, i) => `<path d="M${x} ${y + i * step}h${w}" ${S}/>`).join('');
  const data = {
    'E27': { sub: 'Резьба Эдисона, 27 мм', desc: 'Самый частый цоколь в квартире. Если лампа вкручивается и она крупная, почти наверняка это E27.', where: 'Люстры, торшеры, настольные лампы', lamps: 'Груша, шар, филаментные', volt: '220 В',
      svg: `<svg viewBox="0 0 120 120">${glass('M60 6a30 30 0 0 0-18 54c3 2 5 6 5 10v4h26v-4c0-4 2-8 5-10A30 30 0 0 0 60 6Z')}<path d="M45 74h30v6H45Z" ${S}/>${thread(44, 86, 32, 4, 7)}<path d="M52 112h16" ${S}/></svg>` },
    'E14': { sub: 'Резьба «миньон», 14 мм', desc: 'Узкий винтовой цоколь. Встречается в бра, небольших люстрах, ночниках и вытяжках.', where: 'Бра, ночники, люстры, вытяжки', lamps: 'Свеча, шарик, «свеча на ветру»', volt: '220 В',
      svg: `<svg viewBox="0 0 120 120">${glass('M60 4c-10 14-16 28-16 42 0 12 6 20 8 24h16c2-4 8-12 8-24 0-14-6-28-16-42Z')}<path d="M51 70h18v6H51Z" ${S}/>${thread(52, 82, 16, 4, 7)}<path d="M56 108h8" ${S}/></svg>` },
    'GU10': { sub: 'Два штырька с утолщениями, 10 мм', desc: 'Лампу вставляют и поворачивают на четверть оборота. Работает напрямую от сети, трансформатор не нужен.', where: 'Встраиваемые споты, трековые светильники', lamps: 'Рефлектор MR16, ⌀ 50 мм', volt: '220 В',
      svg: `<svg viewBox="0 0 120 120"><path d="M18 14h84v10L76 70H44L18 24Z" ${S}/><path d="M44 70h32v14H44Z" ${S}/><path d="M50 84v16M70 84v16" ${S}/><circle cx="50" cy="104" r="5" fill="currentColor"/><circle cx="70" cy="104" r="5" fill="currentColor"/></svg>` },
    'GU5.3': { sub: 'Два тонких штырька, 5,3 мм', desc: 'Лампу вставляют прямо в патрон. Классические версии работают от 12 В через трансформатор, есть варианты на 220 В: смотрите маркировку.', where: 'Точечные светильники в потолке', lamps: 'Рефлектор MR16, ⌀ 50 мм', volt: '12 В или 220 В',
      svg: `<svg viewBox="0 0 120 120"><path d="M18 14h84v10L76 70H44L18 24Z" ${S}/><path d="M44 70h32v12H44Z" ${S}/><path d="M55 82v26M65 82v26" ${S}/></svg>` },
    'G9': { sub: 'Две петли, 9 мм между ними', desc: 'Маленькая капсула с проволочными петлями. Лампу вставляют без поворота.', where: 'Люстры с хрусталём, бра, подвесы', lamps: 'Капсула, кукуруза', volt: '220 В',
      svg: `<svg viewBox="0 0 120 120">${glass('M46 14a14 14 0 0 1 28 0v54H46Z')}<path d="M42 68h36v12H42Z" ${S}/><path d="M51 80v14a5 5 0 0 0 10 0V80M59 80v14a5 5 0 0 0 10 0V80" ${S}/></svg>` },
    'G4': { sub: 'Тонкие штырьки, 4 мм', desc: 'Самая маленькая капсула. Почти всегда питается от 12 В.', where: 'Мебельная подсветка, мини-люстры', lamps: 'Капсула', volt: '12 В',
      svg: `<svg viewBox="0 0 120 120">${glass('M50 24a10 10 0 0 1 20 0v44H50Z')}<path d="M47 68h26v10H47Z" ${S}/><path d="M56 78v26M64 78v26" ${S}/></svg>` },
    'T8': { sub: 'Трубка ⌀ 26 мм, штырьки G13', desc: 'Линейная лампа со штырьками с двух сторон. Длина 600 или 1200 мм. Светодиодную трубку можно поставить вместо люминесцентной, если убрать дроссель.', where: 'Гаражи, склады, офисные светильники', lamps: 'Трубка 600 и 1200 мм', volt: '220 В',
      svg: `<svg viewBox="0 0 120 120"><rect x="20" y="48" width="80" height="24" rx="4" ${S}/><path d="M20 52h-6v16h6M100 52h6v16h-6" ${S}/><path d="M14 56H6M14 64H6M106 56h8M106 64h8" ${S}/></svg>` },
    'GX53': { sub: 'Плоская «таблетка», 53 мм между штырьками', desc: 'Лампа в форме диска ⌀ 75 мм. Вставляется и поворачивается. Удобна в тонких потолках.', where: 'Натяжные и подвесные потолки', lamps: 'Таблетка ⌀ 75 мм', volt: '220 В',
      svg: `<svg viewBox="0 0 120 120"><ellipse cx="60" cy="60" rx="46" ry="16" ${S}/><path d="M14 60v10c0 9 20 16 46 16s46-7 46-16V60" ${S}/><path d="M36 50V34M84 50V34" ${S}/><circle cx="36" cy="32" r="4" fill="currentColor"/><circle cx="84" cy="32" r="4" fill="currentColor"/></svg>` }
  };
  const $ = id => document.getElementById(id);
  const card = document.querySelector('.socket-card');
  if (!card) return;
  const btns = document.querySelectorAll('.socket');
  function show(key, animate) {
    const d = data[key];
    $('sfig').innerHTML = d.svg;
    $('sfig').firstChild.setAttribute('aria-hidden', 'true');
    $('sname').textContent = key;
    $('ssub').textContent = d.sub;
    $('sdesc').textContent = d.desc;
    $('swhere').textContent = d.where;
    $('slamps').textContent = d.lamps;
    $('svolt').textContent = d.volt;
    $('slink').firstChild.textContent = 'Лампы ' + key;
    $('slink').href = $('slink').dataset.search + encodeURIComponent(key);
    btns.forEach(b => b.setAttribute('aria-pressed', b.dataset.s === key));
    if (animate) { card.classList.remove('swap'); void card.offsetWidth; card.classList.add('swap'); }
  }
  btns.forEach(b => b.addEventListener('click', () => show(b.dataset.s, true)));
  show('GX53', false);
})();

/* ---------- Catalog panel ---------- */
(function () {
  const btn = document.querySelector('.catalog-btn');
  const panel = document.getElementById('catpanel');
  if (!btn || !panel) return;
  const close = panel.querySelector('.catpanel-close');
  function toggle(open) {
    btn.setAttribute('aria-expanded', open);
    panel.classList.toggle('open', open);
  }
  btn.addEventListener('click', () => toggle(btn.getAttribute('aria-expanded') !== 'true'));
  close.addEventListener('click', () => { toggle(false); btn.focus(); });
  panel.addEventListener('click', e => { if (e.target.closest('a')) toggle(false); });
  document.addEventListener('keydown', e => { if (e.key === 'Escape' && panel.classList.contains('open')) { toggle(false); btn.focus(); } });
  document.addEventListener('click', e => { if (!e.target.closest('.catpanel, .catalog-btn')) toggle(false); });
})();

/* ---------- Reveal on scroll ---------- */
(function () {
  const els = document.querySelectorAll('.reveal, .stagger');
  if (!('IntersectionObserver' in window)) { els.forEach(el => el.classList.add('in')); return; }
  const io = new IntersectionObserver(entries => entries.forEach(e => {
    if (e.isIntersecting) { e.target.classList.add('in'); io.unobserve(e.target); }
  }), { rootMargin: '0px 0px -10% 0px' });
  els.forEach(el => io.observe(el));
})();
