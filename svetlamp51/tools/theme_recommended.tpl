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
        </div>
      </a></li>
      <?php } ?>
    </ul>
  </div>
</section>
<?php } ?>

