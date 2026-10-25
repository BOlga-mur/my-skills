<?php echo $header; ?>
<?php if (!isset($sl_recommended)) $sl_recommended = array(); // set by the SvetLamp home controller ?>
<main class="sl sl-home">
<!-- Hero -->
<section class="hero" aria-labelledby="hero-title">
  <div class="wrap">
    <div>
      <h1 id="hero-title"><span class="ln">Свет для долгой</span> <span class="ln">полярной ночи</span></h1>
      <p class="hero-lead">Лампы, люстры, споты и магнитные треки в выставочном зале в Мурманске. Здесь же Вы найдёте всё для монтажа натяжных потолков, ремонта окон и москитные сетки для защиты от пыли и насекомых.</p>
      <div class="hero-actions">
        <a class="sl-btn sl-btn-accent" href="#catalog"><span class="lbl-long">Открыть каталог</span><span class="lbl-short">Каталог</span><svg aria-hidden="true"><use href="#i-arrow"/></svg></a>
        <a class="sl-btn sl-btn-ghost-night" href="#sockets"><span class="lbl-long">Подобрать лампу по цоколю</span><span class="lbl-short">Подбор по цоколю</span></a>
      </div>
    </div>

    <div class="lampstage">
      <svg class="lamp" viewBox="0 30 600 440" role="img" aria-labelledby="lamp-title">
        <title id="lamp-title">Подвесная лампа светит над столом, оттенок света меняется ползунком</title>
        <defs>
          <radialGradient id="halo" cx="50%" cy="50%" r="50%">
            <stop offset="0%" style="stop-color:var(--glow)" stop-opacity=".55"/>
            <stop offset="45%" style="stop-color:var(--glow)" stop-opacity=".16"/>
            <stop offset="100%" style="stop-color:var(--glow)" stop-opacity="0"/>
          </radialGradient>
          <linearGradient id="beam" x1="0" y1="0" x2="0" y2="1">
            <stop offset="0%" style="stop-color:var(--glow)" stop-opacity=".42"/>
            <stop offset="100%" style="stop-color:var(--glow)" stop-opacity="0.04"/>
          </linearGradient>
          <radialGradient id="pool" cx="50%" cy="50%" r="50%">
            <stop offset="0%" style="stop-color:var(--glow)" stop-opacity=".5"/>
            <stop offset="100%" style="stop-color:var(--glow)" stop-opacity="0"/>
          </radialGradient>
          <radialGradient id="bulbGrad" cx="50%" cy="40%" r="60%">
            <stop offset="0%" stop-color="#fff"/>
            <stop offset="100%" style="stop-color:var(--glow)"/>
          </radialGradient>
        </defs>
        <!-- floor pool and table -->
        <ellipse cx="300" cy="404" rx="250" ry="38" fill="url(#pool)"/>
        <g class="swing">
          <circle cx="300" cy="222" r="190" fill="url(#halo)"/>
          <path class="cone" d="M232 214 L96 404 L504 404 L368 214 Z" fill="url(#beam)"/>
          <line x1="300" y1="0" x2="300" y2="116" stroke="#6b747c" stroke-width="3"/>
          <rect x="284" y="112" width="32" height="18" rx="3" fill="#24292e"/>
          <path d="M300 128 C236 128 208 170 200 218 L400 218 C392 170 364 128 300 128 Z" fill="#2b3137"/>
          <path d="M300 128 C252 128 228 160 218 196" fill="none" stroke="#5f6871" stroke-width="5" stroke-linecap="round"/>
          <ellipse cx="300" cy="218" rx="100" ry="10" style="fill:var(--glow)" opacity=".9"/>
          <circle cx="300" cy="224" r="24" fill="url(#bulbGrad)"/>
        </g>
        <!-- table -->
        <rect x="150" y="390" width="300" height="12" rx="3" fill="#24292e"/>
        <rect x="170" y="402" width="10" height="66" fill="#2b3137"/>
        <rect x="420" y="402" width="10" height="66" fill="#2b3137"/>
        <rect x="150" y="390" width="300" height="3" style="fill:var(--glow)" opacity=".55"/>
        <!-- cup and book on the table -->
        <rect x="200" y="372" width="74" height="18" rx="2" fill="#5f6871"/>
        <rect x="200" y="372" width="74" height="3" style="fill:var(--glow)" opacity=".6"/>
        <path d="M352 360 h28 v26 a4 4 0 0 1 -4 4 h-20 a4 4 0 0 1 -4 -4Z" fill="#5f6871"/>
        <path d="M380 368 a8 8 0 0 1 0 14" fill="none" stroke="#5f6871" stroke-width="4"/>
        <rect x="352" y="360" width="28" height="3" style="fill:var(--glow)" opacity=".7"/>
      </svg>

      <div class="kelvin">
        <div class="kelvin-top">
          <output class="kelvin-value" id="kval" for="kelvin">2700 K</output>
          <span class="kelvin-name" id="kname">Тёплый</span>
        </div>
        <p class="kelvin-note" id="knote">Как у лампы накаливания. Для спальни и гостиной по вечерам.</p>
        <div class="range">
          <span class="range-track" aria-hidden="true"></span>
          <label class="visually-hidden" for="kelvin">Цветовая температура, кельвины</label>
          <input id="kelvin" type="range" min="2700" max="6500" step="50" value="2700" aria-valuetext="2700 кельвинов, тёплый свет">
        </div>
        <div class="ticks" role="group" aria-label="Быстрый выбор температуры">
          <button type="button" data-k="2700" class="on">2700K</button>
          <button type="button" data-k="4000" style="left:34.2%">4000K</button>
          <button type="button" data-k="6500">6500K</button>
        </div>
      </div>
    </div>
  </div>
</section>


<script>
/* Size the hero before the first paint; svetlamp.js keeps it in step on resize */
(function () { var h = document.querySelector('.sl .hero'); if (!h) return; var a = Math.round(h.getBoundingClientRect().top + window.scrollY); document.documentElement.style.setProperty('--above', a + 'px'); h.style.height = (window.innerHeight - a) + 'px'; })();
</script>

<!-- Catalog -->
<section class="section" id="catalog" aria-labelledby="cat-title" style="padding-top:clamp(32px, 3.5vw, 56px)">
  <div class="wrap">
    <div class="section-head reveal">
      <h2 id="cat-title">Каталог</h2>
    </div>
    <div class="cat-group">
      <h3 class="group-title">Свет и электрика</h3>
      <div class="tiles stagger">
        <a class="tile big" href="trekovye-svetilniki" style="--i:0">
          <div>
            <h3>Трековые системы</h3>
            <p>Шинопровод и светильники для него: споты, линейные и поворотные модули. Свет направляете туда, где он нужен.</p>
          </div>
          <svg class="pic" viewBox="0 0 520 200" aria-hidden="true">
            <g fill="none" stroke="currentColor" stroke-width="4" stroke-linecap="round" stroke-linejoin="round">
              <path d="M10 30h500M10 44h500"/>
              <rect x="60" y="44" width="34" height="22" rx="3"/>
              <path d="M77 66v14"/>
              <rect x="58" y="80" width="38" height="56" rx="4"/>
              <rect x="170" y="44" width="150" height="16" rx="3"/>
              <rect x="390" y="44" width="34" height="22" rx="3"/>
              <path d="M407 66l14 22"/>
              <rect x="404" y="86" width="40" height="52" rx="4" transform="rotate(-28 424 112)"/>
            </g>
            <path d="M60 136 L30 196 L124 196 L96 136Z" fill="#ffd38a" opacity=".38"/>
            <rect x="170" y="56" width="150" height="4" fill="#f3ad3c"/>
            <path d="M170 60 L140 196 L350 196 L320 60Z" fill="#ffd38a" opacity=".2"/>
          </svg>
          <span class="more">Смотреть трековые системы<svg aria-hidden="true"><use href="#i-arrow"/></svg></span>
        </a>
        <a class="tile" href="svetodiodnaja-lenta" style="--i:1"><div><h3>Светодиодная лента</h3></div><svg class="pic" aria-hidden="true"><use href="#d-strip"/></svg></a>
        <a class="tile" href="bloki-pitanija" style="--i:2"><div><h3>Блоки питания</h3></div><svg class="pic" aria-hidden="true"><use href="#d-psu"/></svg></a>
        <a class="tile wide" href="vstraivaemye-svetilniki" style="--i:3"><div><h3>Светильники</h3><p>Встраиваемые и накладные</p></div><svg class="pic" aria-hidden="true"><use href="#d-spot"/></svg></a>
        <a class="tile" href="lampy" style="--i:4"><div><h3>Лампы</h3><p>Все цоколи из подбора</p></div><svg class="pic" aria-hidden="true"><use href="#d-bulb"/></svg></a>
        <a class="tile" href="Ljustry" style="--i:5"><div><h3>Люстры</h3></div><svg class="pic" aria-hidden="true"><use href="#d-chandelier"/></svg></a>
        <a class="tile" href="ulichnoe-osveshhenie" style="--i:6"><div><h3>Уличный свет</h3><p>Фасад, крыльцо, участок</p></div><svg class="pic" aria-hidden="true"><use href="#d-street"/></svg></a>
        <a class="tile" href="umnyj-dom" style="--i:7"><div><h3>Умный дом</h3><p>Реле, датчики, умные розетки</p></div><svg class="pic" aria-hidden="true"><use href="#d-smart"/></svg></a>
        <a class="tile" href="upravlenie-svetom" style="--i:8"><div><h3>Управление светом</h3><p>Выключатели, диммеры, датчики движения</p></div><svg class="pic" aria-hidden="true"><use href="#d-switch"/></svg></a>
        <a class="tile" href="elektrika" style="--i:9"><div><h3>Электрика</h3><p>Кабель, розетки, автоматы</p></div><svg class="pic" aria-hidden="true"><use href="#d-electric"/></svg></a>
        <a class="tile" href="kabel-i-provod" style="--i:10"><div><h3>Кабель и провод</h3></div><svg class="pic" aria-hidden="true"><use href="#d-cable"/></svg></a>
        <a class="tile" href="teplyj-pol" style="--i:11"><div><h3>Тёплый пол</h3><p>Кабель, маты, терморегуляторы</p></div><svg class="pic" aria-hidden="true"><use href="#d-floor"/></svg></a>
      </div>
    </div>
    <div class="cat-group">
      <h3 class="group-title">Монтаж и ремонт</h3>
      <div class="tiles tiles-compact stagger">
        <a class="tile dark-soft wide" href="material-dlya-natyazhnyh-potolkov" style="--i:0"><div><h3>Материалы для монтажа натяжных потолков</h3><p>Профили, комплектующие, карнизы</p></div><svg class="pic" aria-hidden="true"><use href="#d-ceiling"/></svg></a>
        <a class="tile dark-soft wide" href="material-dlya-montazha-okon" style="--i:1"><div><h3>Материалы для монтажа окон</h3><p>Подоконники, сэндвич-панели и водоотливы</p></div><svg class="pic" aria-hidden="true"><use href="#d-window"/></svg></a>
        <a class="tile dark-soft" href="germetiki" style="--i:2"><div><h3>Герметики, клей, жидкие гвозди, очистители</h3></div><svg class="pic" aria-hidden="true"><use href="#d-sealant"/></svg></a>
        <a class="tile dark-soft" href="pena-montazhnaya-klej-pena" style="--i:3"><div><h3>Пена монтажная, клей-пена</h3></div><svg class="pic" aria-hidden="true"><use href="#d-foam"/></svg></a>
        <a class="tile dark-soft" href="kosmofeny" style="--i:4"><div><h3>Космофены</h3></div><svg class="pic" aria-hidden="true"><use href="#d-cosmofen"/></svg></a>
        <a class="tile dark-soft" href="karnizy" style="--i:5"><div><h3>Карнизы</h3></div><svg class="pic" aria-hidden="true"><use href="#d-cornice"/></svg></a>
        <a class="tile dark-soft" href="krepezh" style="--i:6"><div><h3>Крепёж</h3></div><svg class="pic" aria-hidden="true"><use href="#d-screw"/></svg></a>
        <a class="tile dark-soft" href="lyuki" style="--i:7"><div><h3>Люки</h3></div><svg class="pic" aria-hidden="true"><use href="#d-hatch"/></svg></a>
        <a class="tile dark-soft" href="dovodchiki-dvernoj-zvonok-cifry" style="--i:8"><div><h3>Доводчики, дверной звонок, цифры</h3></div><svg class="pic" aria-hidden="true"><use href="#d-bell"/></svg></a>
        <a class="tile dark-soft" href="mini-roleta" style="--i:9"><div><h3>Мини Ролеты</h3></div><svg class="pic" aria-hidden="true"><use href="#d-roller"/></svg></a>
        <a class="tile dark-soft wide" href="raznoe-dlya-montazha" style="--i:10"><div><h3>Разное</h3><p>Расходные материалы, инструменты и химия</p></div><svg class="pic" aria-hidden="true"><use href="#d-tool"/></svg></a>
        <a class="tile dark-soft wide" href="moskitnaya-setka" style="--i:11"><div><h3>Москитные сетки</h3><p>Защита от пыли и насекомых</p></div><svg class="pic" aria-hidden="true"><use href="#d-net"/></svg></a>
      </div>
    </div>
    </div>
  </div>
</section>

<!-- Socket picker -->
<section class="section sockets-sec" id="sockets" aria-labelledby="sock-title">
  <div class="wrap">
    <div class="section-head reveal">
      <h2 id="sock-title">Подбор по цоколю</h2>
      <p>Именно цоколь становится причиной многих ошибок при покупке. Выберите свой или принесите старую лампу в зал.</p>
    </div>
    <div class="sockets" role="group" aria-label="Цоколи">
      <button class="socket" type="button" aria-pressed="true" data-s="GX53">GX53</button>
      <button class="socket" type="button" aria-pressed="false" data-s="GU5.3">GU5.3</button>
      <button class="socket" type="button" aria-pressed="false" data-s="GU10">GU10</button>
      <button class="socket" type="button" aria-pressed="false" data-s="E14">E14</button>
      <button class="socket" type="button" aria-pressed="false" data-s="E27">E27</button>
      <button class="socket" type="button" aria-pressed="false" data-s="G9">G9</button>
      <button class="socket" type="button" aria-pressed="false" data-s="G4">G4</button>
      <button class="socket" type="button" aria-pressed="false" data-s="T8">T8</button>
    </div>
    <div class="socket-card" aria-live="polite">
      <div class="socket-figure" id="sfig"></div>
      <div class="socket-info">
        <h3 id="sname">GX53</h3>
        <p class="sub" id="ssub">Плоская «таблетка», 53 мм между штырьками</p>
        <p class="desc" id="sdesc">Лампа в форме диска ⌀ 75 мм. Вставляется и поворачивается. Удобна в тонких потолках.</p>
      </div>
      <div class="socket-facts">
        <dl>
        <div><dt>Где стоит</dt><dd id="swhere">Натяжные и подвесные потолки</dd></div>
        <div><dt>Какие лампы</dt><dd id="slamps">Таблетка ⌀ 75 мм</dd></div>
        <div><dt>Напряжение</dt><dd id="svolt">220 В</dd></div>
        </dl>
        <a class="sl-btn sl-btn-ink" id="slink" href="index.php?route=product/search&amp;search=GX53" data-search="index.php?route=product/search&amp;search=">Лампы GX53<svg aria-hidden="true"><use href="#i-arrow"/></svg></a>
      </div>
    </div>
  </div>
</section>

<?php if ($sl_recommended) { ?>
<!-- Recommended: products from the "Рекомендуемые" module on the home page layout -->
<section class="section" id="recommended" aria-labelledby="rec-title">
  <div class="wrap">
    <div class="section-head reveal">
      <h2 id="rec-title">Рекомендуем</h2>
      <p>Это чаще всего покупают зимой.</p>
    </div>
    <ul class="cards stagger">
      <?php foreach ($sl_recommended as $i => $product) { ?>
      <li style="--i:<?php echo $i; ?>"><a class="card" href="<?php echo $product['href']; ?>">
        <div class="card-pic"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" loading="lazy" /></div>
        <div class="card-body">
          <span class="card-cat"><?php echo $product['caption']; ?></span>
          <h3><?php echo $product['name']; ?></h3>
          <ul class="tags">
            <?php foreach ($product['tags'] as $tag) { ?>
            <?php
            // Colour temperature tags get the colour of their light
            $tag_class = '';
            if (preg_match('/(\d{4})\s*[KК]/u', $tag, $kelvin)) {
              $tag_class = $kelvin[1] < 3500 ? 'warm' : ($kelvin[1] <= 5000 ? 'neutral' : 'cool');
            }
            ?>
            <li<?php echo $tag_class ? ' class="' . $tag_class . '"' : ''; ?>><?php echo $tag; ?></li>
            <?php } ?>
          </ul>
        </div>
      </a></li>
      <?php } ?>
    </ul>
  </div>
</section>
<?php } ?>

<!-- Showroom -->
<section class="section showroom" id="showroom" aria-labelledby="show-title">
  <div class="wrap showroom-grid">
    <div class="reveal">
      <h2 id="show-title">Выставочный зал</h2>
      <p class="lead showroom-lead">Возьмите с собой старую лампу или фото светильника. По ним проще подобрать цоколь и мощность.</p>
      <dl class="contacts">
        <div><dt>Адрес</dt><dd>Мурманск, проезд Молодёжный, 12, корпус&nbsp;1</dd></div>
        <div><dt>Часы</dt><dd>пн–сб 9:00–18:00, вс выходной</dd></div>
        <div><dt>Телефон</dt><dd><a href="tel:+79113007887">+7 911 300-78-87</a></dd></div>
        <div><dt>Почта</dt><dd><a href="mailto:707887@bk.ru">707887@bk.ru</a></dd></div>
      </dl>
      <div class="showroom-actions">
        <a class="sl-btn sl-btn-accent" href="https://yandex.ru/maps/?rtext=~68.931948%2C33.119349&amp;ruri=~ymapsbm1%3A%2F%2Forg%3Foid%3D1166074602&amp;rtt=auto" target="_blank" rel="noopener"><svg aria-hidden="true"><use href="#i-route"/></svg>Построить маршрут</a>
        <a class="sl-btn sl-btn-ghost-night" href="tel:+79113007887"><svg aria-hidden="true"><use href="#i-phone"/></svg>Позвонить</a>
      </div>
    </div>
    <div class="showroom-map" id="map">
      <!-- КАРТА: код виджета Яндекс Карт. Чтобы заменить, вставьте новый код вместо строки ниже. -->
      <div style="position:relative;overflow:hidden;"><a href="https://yandex.ru/maps/org/svetlamp/1166074602/?utm_medium=mapframe&utm_source=maps" style="color:#eee;font-size:12px;position:absolute;top:0px;">СветЛамп</a><a href="https://yandex.ru/maps/23/murmansk/category/lamps/184108003/?utm_medium=mapframe&utm_source=maps" style="color:#eee;font-size:12px;position:absolute;top:14px;">Светильники в Мурманске</a><a href="https://yandex.ru/maps/23/murmansk/category/ceiling_systems/184107719/?utm_medium=mapframe&utm_source=maps" style="color:#eee;font-size:12px;position:absolute;top:28px;">Потолочные системы в Мурманске</a><iframe src="https://yandex.ru/map-widget/v1/?ll=33.119349%2C68.931948&mode=search&oid=1166074602&ol=biz&z=16.61" width="560" height="400" frameborder="1" allowfullscreen="true" style="position:relative;" title="СветЛамп на Яндекс Картах" loading="lazy"></iframe></div>
    </div>
  </div>
</section>
</main>
<?php echo $footer; ?>
