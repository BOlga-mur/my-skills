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
          <?php if ($product['caption']) { ?><span class="card-cat"><?php echo $product['caption']; ?></span><?php } ?>
          <h3><?php echo $product['name']; ?></h3>
          <?php if ($product['tags']) { ?>
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
          <?php } ?>
        </div>
      </a></li>
      <?php } ?>
    </ul>
  </div>
</section>
<?php } ?>

