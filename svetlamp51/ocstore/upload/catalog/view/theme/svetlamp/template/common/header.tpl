<!DOCTYPE html>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title><?php echo $title; ?></title>
<?php if (!empty($noindex)) { ?>
<!-- OCFilter Start -->
<meta name="robots" content="noindex,nofollow" />
<!-- OCFilter End -->
<?php } ?>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content="<?php echo $keywords; ?>" />
<?php } ?>
<meta property="og:title" content="<?php echo $title; ?>" />
<meta property="og:type" content="website" />
<meta property="og:url" content="<?php echo $og_url; ?>" />
<?php if ($og_image) { ?>
<meta property="og:image" content="<?php echo $og_image; ?>" />
<?php } else { ?>
<meta property="og:image" content="<?php echo $logo; ?>" />
<?php } ?>
<meta property="og:site_name" content="<?php echo $name; ?>" />
<meta name="theme-color" content="#3d454d">
<script>document.documentElement.className += ' js';</script>
<script src="catalog/view/javascript/jquery/jquery-2.1.1.min.js" type="text/javascript"></script>
<link href="catalog/view/javascript/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen" />
<script src="catalog/view/javascript/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<link href="catalog/view/javascript/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Onest:wght@400;500;600;700&display=swap" rel="stylesheet">
<link href="catalog/view/theme/svetlamp/stylesheet/stylesheet.css" rel="stylesheet">
<?php foreach ($styles as $style) { ?>
<link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<link href="catalog/view/theme/svetlamp/stylesheet/svetlamp.css?v=3" rel="stylesheet">
<link href="catalog/view/theme/svetlamp/stylesheet/svetlamp-pages.css?v=3" rel="stylesheet">
<script src="catalog/view/javascript/common.js" type="text/javascript"></script>
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<?php foreach ($scripts as $script) { ?>
<script src="<?php echo $script; ?>" type="text/javascript"></script>
<?php } ?>
<?php foreach ($analytics as $analytic) { ?>
<?php echo $analytic; ?>
<?php } ?>
</head>
<body class="<?php echo $class; ?> sl-body">
<div class="sl sl-top">
<svg width="0" height="0" style="position:absolute" aria-hidden="true">
  <defs>
    <symbol id="i-arrow" viewBox="0 0 24 24"><path d="M5 12h14M13 6l6 6-6 6" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/></symbol>
    <symbol id="i-pin" viewBox="0 0 24 24"><path d="M12 21s-7-6.2-7-11.5a7 7 0 1 1 14 0C19 14.8 12 21 12 21Z" fill="none" stroke="currentColor" stroke-width="2"/><circle cx="12" cy="9.5" r="2.5" fill="currentColor"/></symbol>
    <symbol id="i-clock" viewBox="0 0 24 24"><circle cx="12" cy="12" r="9" fill="none" stroke="currentColor" stroke-width="2"/><path d="M12 7v5l3 2" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"/></symbol>
    <symbol id="i-phone" viewBox="0 0 24 24"><path d="M6.6 3h3l1.6 4.4-2.2 1.4a11 11 0 0 0 6.2 6.2l1.4-2.2L21 14.4v3A2.6 2.6 0 0 1 18.2 20 15.6 15.6 0 0 1 4 5.8 2.6 2.6 0 0 1 6.6 3Z" fill="none" stroke="currentColor" stroke-width="2" stroke-linejoin="round"/></symbol>
    <symbol id="i-mail" viewBox="0 0 24 24"><rect x="3" y="5" width="18" height="14" rx="2" fill="none" stroke="currentColor" stroke-width="2"/><path d="m4 7 8 6 8-6" fill="none" stroke="currentColor" stroke-width="2" stroke-linejoin="round"/></symbol>
    <symbol id="i-search" viewBox="0 0 24 24"><circle cx="10.5" cy="10.5" r="6.5" fill="none" stroke="currentColor" stroke-width="2"/><path d="m15.5 15.5 5 5" stroke="currentColor" stroke-width="2" stroke-linecap="round"/></symbol>
    <symbol id="i-route" viewBox="0 0 24 24"><circle cx="6" cy="18" r="2.5" fill="none" stroke="currentColor" stroke-width="2"/><circle cx="18" cy="6" r="2.5" fill="none" stroke="currentColor" stroke-width="2"/><path d="M8.5 18H15a3 3 0 0 0 0-6H9a3 3 0 0 1 0-6h6.5" fill="none" stroke="currentColor" stroke-width="2"/></symbol>
    <symbol id="i-bulb" viewBox="0 0 24 24"><path d="M9 18h6M10 21h4M12 3a6 6 0 0 0-3.6 10.8c.6.5 1 1.2 1 2V16h5.2v-.2c0-.8.4-1.5 1-2A6 6 0 0 0 12 3Z" fill="none" stroke="currentColor" stroke-width="2" stroke-linejoin="round"/></symbol>

    <!-- Drawings: one stroke language, 120x120 -->
    <symbol id="d-chandelier" viewBox="0 0 120 120"><g fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><path d="M60 4v26"/><circle cx="60" cy="34" r="5"/><path d="M60 39v20M20 54c10 12 30 14 40 5 10 9 30 7 40-5"/><path d="M20 54v12M100 54v12M60 59v14"/><path d="M12 66h16l-3 16H15ZM92 66h16l-3 16H95ZM52 73h16l-3 16H55Z"/></g><g fill="currentColor"><circle cx="20" cy="88" r="3"/><circle cx="100" cy="88" r="3"/><circle cx="60" cy="95" r="3"/></g></symbol>
    <symbol id="d-pendant" viewBox="0 0 120 120"><g fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><path d="M60 4v40"/><path d="M52 44h16v8H52Z"/><path d="M60 52c-26 0-40 16-42 34h84c-2-18-16-34-42-34Z"/><path d="M50 86a10 10 0 0 0 20 0"/></g></symbol>
    <symbol id="d-spot" viewBox="0 0 120 120"><g fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><path d="M10 30h100"/><path d="M34 30v8a26 26 0 0 0 52 0v-8"/><circle cx="60" cy="40" r="12"/><path d="M40 86l-8 22M60 90v22M80 86l8 22" stroke-dasharray="4 7"/></g></symbol>
    <symbol id="d-strip" viewBox="0 0 120 120"><g fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><path d="M14 92c0-30 12-50 46-50h46"/><path d="M14 104c0-36 16-50 46-50h46" opacity=".4"/></g><g fill="currentColor"><rect x="22" y="72" width="7" height="7" rx="1"/><rect x="36" y="52" width="7" height="7" rx="1"/><rect x="56" y="45" width="7" height="7" rx="1"/><rect x="76" y="45" width="7" height="7" rx="1"/><rect x="96" y="45" width="7" height="7" rx="1"/></g></symbol>
    <symbol id="d-bulb" viewBox="0 0 120 120"><g fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><path d="M60 8a32 32 0 0 0-20 57c4 3 6 8 6 13v4h28v-4c0-5 2-10 6-13A32 32 0 0 0 60 8Z"/><path d="M46 82h28v8H46ZM47 90h26M48 96h24M50 102h20M54 108h12"/><path d="M52 64V44l8 8 8-8v20"/></g></symbol>
    <symbol id="d-sconce" viewBox="0 0 120 120"><g fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><rect x="14" y="40" width="14" height="40" rx="3"/><path d="M28 60h26c10 0 14-8 14-16"/><path d="M48 44h40l10 30H38Z"/><path d="M58 74v10M78 74v10" stroke-dasharray="3 6"/></g></symbol>
    <symbol id="d-street" viewBox="0 0 120 120"><g fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><path d="M36 114V24c0-10 8-16 18-16h20"/><path d="M62 16h30l6 12H56Z"/><path d="M24 114h24"/><path d="M68 36l-8 20M77 36v22M86 36l8 20" stroke-dasharray="3 6"/></g></symbol>
    <symbol id="d-ceiling" viewBox="0 0 120 120"><g fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><path d="M8 26h104M8 26v70M112 26v70"/><path d="M8 40c30 6 74 6 104 0"/><circle cx="40" cy="45" r="5"/><circle cx="80" cy="45" r="5"/><path d="M8 96h104"/></g></symbol>
    <symbol id="d-window" viewBox="0 0 120 120"><g fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><rect x="16" y="10" width="88" height="96" rx="2"/><path d="M60 10v96M16 58h44"/><path d="M70 50v16"/><path d="M8 106h104"/></g><g fill="currentColor"><circle cx="34" cy="32" r="2"/><circle cx="40" cy="26" r="1.5"/></g></symbol>
    <symbol id="d-net" viewBox="0 0 120 120"><g fill="none" stroke="currentColor" stroke-width="3" stroke-linejoin="round"><rect x="20" y="10" width="80" height="100" rx="3"/></g><g stroke="currentColor" stroke-width="1.6" opacity=".7"><path d="M20 22h80M20 34h80M20 46h80M20 58h80M20 70h80M20 82h80M20 94h80M32 10v100M44 10v100M56 10v100M68 10v100M80 10v100M92 10v100"/></g></symbol>
    <symbol id="d-tool" viewBox="0 0 120 120"><g fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><path d="M20 40h46l8 10v12H20Z"/><path d="M74 54h18M92 50v8"/><path d="M36 62l-4 40h22l6-40"/><path d="M48 62v14"/></g></symbol>
    <symbol id="d-track" viewBox="0 0 120 120"><g fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><path d="M6 24h108"/><path d="M6 32h108"/><path d="M24 32v16h14V32ZM68 32v10h28v-10"/><path d="M31 48v12a10 10 0 0 0 0 0"/><rect x="22" y="58" width="18" height="30" rx="2"/></g><g fill="currentColor"><rect x="68" y="42" width="28" height="6" rx="1"/></g></symbol>
    <symbol id="d-psu" viewBox="0 0 120 120"><g fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><rect x="14" y="40" width="92" height="44" rx="4"/><path d="M28 52v20M38 52v20M48 52v20M58 52v20"/><path d="M106 54h8M106 70h8M6 54h8M6 70h8"/><path d="M82 52l-6 10h8l-6 10"/></g></symbol>
    <symbol id="d-smart" viewBox="0 0 120 120"><g fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><path d="M16 58L60 22l44 36"/><path d="M28 50v56h64V50"/><path d="M42 76a26 26 0 0 1 36 0"/><path d="M50 85a14 14 0 0 1 20 0"/></g><circle cx="60" cy="94" r="3.5" fill="currentColor"/></symbol>
    <symbol id="d-switch" viewBox="0 0 120 120"><g fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><rect x="22" y="18" width="76" height="84" rx="8"/><rect x="44" y="36" width="32" height="48" rx="5"/><path d="M44 60h32"/><path d="M52 48h16" stroke-width="2"/></g></symbol>
    <symbol id="d-electric" viewBox="0 0 120 120"><g fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><path d="M44 14v20M76 14v20"/><path d="M32 34h56v16a28 28 0 0 1-56 0Z"/><path d="M60 78v10c0 12 8 18 22 18h24"/></g></symbol>
    <symbol id="d-floor" viewBox="0 0 120 120"><g fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><path d="M8 92h104"/><path d="M14 106h84a7 7 0 0 0 0-14"/><path d="M38 70c-6-7 6-13 0-20s6-13 0-20M60 70c-6-7 6-13 0-20s6-13 0-20M82 70c-6-7 6-13 0-20s6-13 0-20"/></g></symbol>
    <symbol id="d-sealant" viewBox="0 0 120 120"><g fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><rect x="12" y="42" width="66" height="36" rx="4"/><path d="M26 42v36"/><path d="M78 48l28 10v4l-28 10"/></g></symbol>
    <symbol id="d-foam" viewBox="0 0 120 120"><g fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><rect x="38" y="40" width="40" height="70" rx="8"/><path d="M46 40V30h24v10"/><path d="M58 30V20h24l14 6"/><path d="M38 60h40" stroke-width="2"/></g></symbol>
    <symbol id="d-cosmofen" viewBox="0 0 120 120"><g fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><path d="M16 46l8 14-8 14h64V46Z"/><path d="M80 52h12v16H80"/><path d="M92 56h16v8H92"/></g></symbol>
    <symbol id="d-cornice" viewBox="0 0 120 120"><g fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><path d="M8 22h104"/><path d="M28 30c-4 28 4 50 0 80M48 30c4 28-4 50 0 80M72 30c-4 28 4 50 0 80M92 30c4 28-4 50 0 80"/></g><g fill="currentColor"><circle cx="8" cy="22" r="5"/><circle cx="112" cy="22" r="5"/></g></symbol>
    <symbol id="d-screw" viewBox="0 0 120 120"><g fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><path d="M38 18h44l-8 14H46Z"/><path d="M50 32v56l10 18 10-18V32"/><path d="M50 44l20 7M50 58l20 7M50 72l20 7"/></g></symbol>
    <symbol id="d-hatch" viewBox="0 0 120 120"><g fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><rect x="14" y="14" width="92" height="92" rx="3"/><rect x="28" y="28" width="64" height="64" rx="2"/></g><circle cx="80" cy="60" r="4" fill="currentColor"/></symbol>
    <symbol id="d-bell" viewBox="0 0 120 120"><g fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><path d="M60 14v8"/><path d="M34 80V56a26 26 0 0 1 52 0v24l10 10H24Z"/><path d="M50 98a10 10 0 0 0 20 0"/></g></symbol>
    <symbol id="d-cable" viewBox="0 0 120 120"><g fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><circle cx="56" cy="54" r="38"/><circle cx="56" cy="54" r="24"/><circle cx="56" cy="54" r="9"/><path d="M94 54c0 28 8 46 20 52"/></g></symbol>
    <symbol id="d-roller" viewBox="0 0 120 120"><g fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><rect x="14" y="14" width="92" height="14" rx="7"/><path d="M22 28v62h76V28"/><path d="M18 90h84"/><path d="M106 28v44"/></g><circle cx="106" cy="76" r="4" fill="currentColor"/></symbol>
    <symbol id="d-gx53" viewBox="0 0 120 120"><g fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><ellipse cx="60" cy="54" rx="44" ry="14"/><path d="M16 54v10c0 8 20 14 44 14s44-6 44-14V54"/><path d="M42 42v-12M78 42v-12"/></g></symbol>
  </defs>
</svg>

<div class="topbar">
  <div class="wrap">
    <span class="tb-item tb-addr"><svg aria-hidden="true"><use href="#i-pin"/></svg><span><span class="tb-long">Мурманск, проезд </span>Молодёжный, 12, корпус 1</span></span>
    <span class="tb-item tb-hide"><svg aria-hidden="true"><use href="#i-clock"/></svg>пн–сб 9:00–18:00</span>
    <span class="tb-right">
      <a class="tb-item" href="tel:+79113007887"><svg aria-hidden="true"><use href="#i-phone"/></svg>+7 911 300-78-87</a>
      <a class="tb-item tb-mail" href="mailto:707887@bk.ru"><svg aria-hidden="true"><use href="#i-mail"/></svg>707887@bk.ru</a>
    </span>
  </div>
</div>

<header class="header">
  <div class="wrap header-row">
    <a class="logo" href="<?php echo $home; ?>" aria-label="СветЛамп, на главную">
      <span class="logo-mark" aria-hidden="true">
        <svg viewBox="0 0 28 28"><path d="M14 2v6" stroke="#eef2f4" stroke-width="2" stroke-linecap="round"/><path d="M5 18c0-5 4-9 9-9s9 4 9 9Z" fill="#eef2f4"/><circle cx="14" cy="21" r="3.5" fill="#f3ad3c"/></svg>
      </span>
      <span class="logo-text">СветЛамп<small>свет, потолки и окна в Мурманске</small></span>
    </a>
    <button class="sl-btn sl-btn-ink catalog-btn" type="button" aria-expanded="false" aria-controls="catpanel">
      <span class="burger" aria-hidden="true"><i></i><i></i><i></i></span>Каталог
    </button>
    <?php echo $search; ?>
  </div>
  <div class="catpanel" id="catpanel">
    <button class="sl-btn sl-btn-soft catpanel-close" type="button">Закрыть</button>
    <div class="wrap">
      <div><h3><a href="osveshchenie">Освещение</a></h3><ul><li><a href="trekovye-svetilniki">Трековые системы</a></li><li><a href="svetodiodnaja-lenta">Светодиодная лента</a></li><li><a href="bloki-pitanija">Блоки питания</a></li><li><a href="vstraivaemye-svetilniki">Светильники</a></li><li><a href="lampy">Лампы</a></li><li><a href="Ljustry">Люстры</a></li><li><a href="ulichnoe-osveshhenie">Уличный свет</a></li><li><a href="umnyj-dom">Умный дом</a></li><li><a href="upravlenie-svetom">Управление светом</a></li><li><a href="elektrika">Электрика</a></li></ul></div>
      <div><h3><a href="material-dlya-natyazhnyh-potolkov">Материалы для монтажа натяжных потолков</a></h3><ul><li><a href="baget">Багет</a></li><li><a href="komplektuyushchie-dlya-profilya">Комплектующие для профиля</a></li><li><a href="lenta-maskirovochnaya">Лента маскировочная</a></li><li><a href="platformy">Платформы</a></li><li><a href="termokolca-termokvadraty">Термокольца, термоквадраты</a></li><li><a href="obvody-dlya-trub">Обводы для труб</a></li><li><a href="plastikovye-listy">Пластиковые листы</a></li><li><a href="karnizy">Карнизы</a></li></ul></div>
      <div><h3><a href="material-dlya-montazha-okon">Материалы для монтажа окон</a></h3><ul><li><a href="podokonnik-pvh">Подоконник ПВХ</a></li><li><a href="podokonnik-myoller">Подоконник Moeller</a></li><li><a href="sendvich-paneli">Сэндвич-панели</a></li><li><a href="vodootlivy-dlya-okon">Водоотливы для окон</a></li><li><a href="torcevye-nakladki">Торцевые накладки</a></li><li><a href="plastikovye-ugolki-na-okna">Пластиковые уголки на окна</a></li><li><a href="nashchelnik">Нащельник</a></li><li><a href="uplotnitel-dlya-okon">Уплотнитель для окон</a></li><li><a href="furnitura-dlya-okon">Фурнитура для окон</a></li><li><a href="lenta-dlya-montazha-okon-po-gostu">Лента для монтажа окон по ГОСТу</a></li><li><a href="mini-roleta">Мини Ролеты</a></li><li><a href="moskitnaya-setka">Москитные сетки</a></li></ul></div>
      <div><h3><a href="raznoe-dlya-montazha">Монтаж и ремонт</a></h3><ul><li><a href="germetiki">Герметики, клей, жидкие гвозди, очистители</a></li><li><a href="pena-montazhnaya-klej-pena">Пена монтажная, клей-пена</a></li><li><a href="kosmofeny">Космофены</a></li><li><a href="krepezh">Крепёж</a></li><li><a href="dovodchiki-dvernoj-zvonok-cifry">Доводчики, дверной звонок, цифры</a></li><li><a href="lyuki">Люки</a></li><li><a href="kabel-i-provod">Кабель и провод</a></li><li><a href="teplyj-po">Тёплый пол</a></li><li><a href="raznoe-dlya-montazha">Разное</a></li></ul></div>
    </div>
  </div>
</header>

<!-- Directions -->
<nav class="directions" id="directions" aria-label="Направления">
  <div class="wrap">
    <ul class="dirs">
      <li><a class="dir" href="material-dlya-natyazhnyh-potolkov"><span class="dir-name">Натяжные потолки</span><span class="dir-desc">профили, комплектующие, карнизы</span></a></li>
      <li><a class="dir" href="material-dlya-montazha-okon"><span class="dir-name">Монтаж окон</span><span class="dir-desc">подоконники, сэндвич-панели и водоотливы</span></a></li>
      <li><a class="dir" href="osveshchenie"><span class="dir-name">Освещение и электрика</span><span class="dir-desc">лампы, светильники, лента, кабель, управление светом</span></a></li>
      <li><a class="dir" href="raznoe-dlya-montazha"><span class="dir-name">Разное</span><span class="dir-desc">расходные материалы, инструменты и химия</span></a></li>
      <li><a class="dir" href="moskitnaya-setka"><span class="dir-name">Москитные сетки</span><span class="dir-desc">защита от пыли и насекомых</span></a></li>
    </ul>
  </div>
</nav>
</div>
