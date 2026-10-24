<div class="sl">
<footer class="footer" id="footer">
  <div class="wrap">
    <div class="footer-grid">
      <div>
        <span class="logo-text">СветЛамп<small>свет, потолки и окна в Мурманске</small></span>
      </div>
      <div>
        <h2>Телефон и часы</h2>
        <a class="phone" href="tel:+79113007887">+7 911 300-78-87</a>
        <p style="margin-top:8px">пн–сб 9:00–18:00</p>
        <p>Мурманск, проезд Молодёжный, 12, корпус 1</p>
      </div>
      <nav aria-label="О компании">
        <h2>Разделы</h2>
        <ul>
          <?php foreach ($informations as $information) { ?>
          <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
          <?php } ?>
          <li><a href="<?php echo $contact; ?>">Контакты</a></li>
          <li><a href="mailto:707887@bk.ru">707887@bk.ru</a></li>
        </ul>
      </nav>
    </div>
    <div class="footer-bottom">
      <span>© СветЛамп, Мурманск</span>
      <span>Информация на сайте не является публичной офертой</span>
    </div>
  </div>
</footer>
</div>
<?php if (!empty($scripts)) { foreach ($scripts as $script) { ?>
<script src="<?php echo $script; ?>" type="text/javascript"></script>
<?php } } ?>
<script src="catalog/view/theme/svetlamp/javascript/svetlamp.js?v=3"></script>
</body></html>
