<?php echo $header; ?>
<?php // SvetLamp: no left column on category pages (filter and category list removed), products use the full width
$column_left = ''; ?>
<div class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
      <h1><?php echo $heading_title; ?></h1>
      <?php if ($thumb || $description) { ?>
      
      <hr>
      <?php } ?>
      <?php if ($categories) { ?>
      <div class="sl-subcats">
        <?php foreach ($categories as $category) { ?>
        <a class="sl-subcat<?php echo !empty($category['thumb']) ? ' has-pic' : ''; ?>" href="<?php echo $category['href']; ?>"><span><?php echo $category['name']; ?></span><?php if (!empty($category['thumb'])) { ?><img src="<?php echo $category['thumb']; ?>" alt="" width="120" height="120" loading="lazy"><?php } else { ?><svg viewBox="0 0 24 24" aria-hidden="true"><path d="M5 12h14M13 6l6 6-6 6" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/></svg><?php } ?></a>
        <?php } ?>
      </div>
      <?php } ?>
      <?php if (!empty($sl_filters)) { ?>
      <!-- Filter rows: filled by the «СветЛамп: фильтр по мощности и напряжению» modification -->
      <div class="sl-filters">
      <?php foreach ($sl_filters as $sl_filter_row) { ?>
      <?php if (isset($sl_filter_row['type']) && $sl_filter_row['type'] == 'range') { ?>
      <?php $sl_vals = $sl_filter_row['values']; $sl_fmt = function ($v) { return str_replace('.', ',', rtrim(rtrim(number_format($v, 2, '.', ''), '0'), '.')); }; ?>
      <div class="sl-power sl-range" data-base="<?php echo $sl_filter_row['base']; ?>" data-param="<?php echo $sl_filter_row['param']; ?>" data-unit="<?php echo $sl_filter_row['unit']; ?>" data-values="<?php echo htmlspecialchars(json_encode($sl_vals)); ?>">
        <span class="sl-power-label" id="sl-range-<?php echo $sl_filter_row['param']; ?>"><?php echo $sl_filter_row['label']; ?></span>
        <div class="sl-range-box">
          <output class="sl-range-out">от <?php echo $sl_fmt($sl_vals[$sl_filter_row['from']]); ?> до <?php echo $sl_fmt($sl_vals[$sl_filter_row['to']]); ?> <?php echo $sl_filter_row['unit']; ?></output>
          <div class="sl-range-track">
            <div class="sl-range-fill"></div>
            <input type="range" class="sl-range-from" min="0" max="<?php echo count($sl_vals) - 1; ?>" step="1" value="<?php echo $sl_filter_row['from']; ?>" aria-label="<?php echo $sl_filter_row['label']; ?> от" />
            <input type="range" class="sl-range-to" min="0" max="<?php echo count($sl_vals) - 1; ?>" step="1" value="<?php echo $sl_filter_row['to']; ?>" aria-label="<?php echo $sl_filter_row['label']; ?> до" />
          </div>
          <div class="sl-range-ends"><span><?php echo $sl_fmt($sl_vals[0]); ?></span><span><?php echo $sl_fmt($sl_vals[count($sl_vals) - 1]); ?></span></div>
        </div>
        <?php if ($sl_filter_row['reset']) { ?>
        <a class="sl-chip-reset" href="<?php echo $sl_filter_row['reset']; ?>">Сбросить</a>
        <?php } ?>
      </div>
      <?php continue; } ?>
      <div class="sl-power" role="group" aria-label="<?php echo $sl_filter_row['label']; ?>">
        <span class="sl-power-label"><?php echo $sl_filter_row['label']; ?></span>
        <ul class="sl-chips">
          <?php foreach ($sl_filter_row['options'] as $sl_option) { ?>
          <li><a href="<?php echo $sl_option['href']; ?>"<?php echo $sl_option['active'] ? ' class="active" aria-current="true"' : ''; ?>><?php echo $sl_option['name']; ?> <span class="sl-chip-count"><?php echo $sl_option['total']; ?></span></a></li>
          <?php } ?>
          <?php if ($sl_filter_row['reset']) { ?>
          <li><a class="sl-chip-reset" href="<?php echo $sl_filter_row['reset']; ?>">Сбросить</a></li>
          <?php } ?>
        </ul>
      </div>
      <?php } ?>
      </div>
      <script>
      // Power slider: the handles step over the values that exist; letting go opens the filtered list
      document.querySelectorAll('.sl-range').forEach(function (box) {
        var values = JSON.parse(box.dataset.values), from = box.querySelector('.sl-range-from'), to = box.querySelector('.sl-range-to');
        var out = box.querySelector('.sl-range-out'), fill = box.querySelector('.sl-range-fill'), last = values.length - 1;
        function fmt(v) { return String(Math.round(v * 100) / 100).replace('.', ','); }
        function draw(moved) {
          if (+from.value > +to.value) { if (moved === from) { from.value = to.value; } else { to.value = from.value; } }
          out.textContent = 'от ' + fmt(values[from.value]) + ' до ' + fmt(values[to.value]) + ' ' + box.dataset.unit;
          fill.style.left = (from.value / last * 100) + '%';
          fill.style.right = (100 - to.value / last * 100) + '%';
          // both handles at the right end: the left one stays on top, so it can still be pulled back
          from.style.zIndex = +from.value === last ? 3 : '';
        }
        var timer;
        function go() {
          // a short pause, so several arrow-key steps make one request
          clearTimeout(timer);
          timer = setTimeout(open, 700);
        }
        function open() {
          var url = box.dataset.base;
          if (+from.value > 0 || +to.value < last) {
            url += (url.indexOf('?') < 0 ? '?' : '&') + box.dataset.param + '_from=' + values[from.value] + '&' + box.dataset.param + '_to=' + values[to.value];
          }
          location.href = url;
        }
        [from, to].forEach(function (input) {
          input.addEventListener('input', function () { draw(input); });
          input.addEventListener('change', go);
        });
        draw();
      });
      </script>
      <?php } ?>
      <?php if ($products) { ?>
      <div class="row">
        <div class="col-md-2 col-sm-6 hidden-xs">
          <div class="btn-group btn-group-sm">
            <button type="button" id="list-view" class="btn btn-default" data-toggle="tooltip" title="<?php echo $button_list; ?>"><i class="fa fa-th-list"></i></button>
            <button type="button" id="grid-view" class="btn btn-default" data-toggle="tooltip" title="<?php echo $button_grid; ?>"><i class="fa fa-th"></i></button>
          </div>
        </div>
        <div class="col-md-3 col-sm-6">
          <div class="form-group">
            <a href="<?php echo $compare; ?>" id="compare-total" class="btn btn-link"><?php echo $text_compare; ?></a>
          </div>
        </div>
        <div class="col-md-4 col-xs-6">
          <div class="form-group input-group input-group-sm">
            <label class="input-group-addon" for="input-sort"><?php echo $text_sort; ?></label>
            <select id="input-sort" class="form-control" onchange="location = this.value;">
              <?php foreach ($sorts as $sorts) { ?>
              <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
              <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
              <?php } ?>
              <?php } ?>
            </select>
          </div>
        </div>
        <div class="col-md-3 col-xs-6">
          <div class="form-group input-group input-group-sm">
            <label class="input-group-addon" for="input-limit"><?php echo $text_limit; ?></label>
            <select id="input-limit" class="form-control" onchange="location = this.value;">
              <?php foreach ($limits as $limits) { ?>
              <?php if ($limits['value'] == $limit) { ?>
              <option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
              <?php } ?>
              <?php } ?>
            </select>
          </div>
        </div>
      </div>
      <div class="row">
        <?php foreach ($products as $product) { ?>
        <div class="product-layout product-list col-xs-12">
          <div class="product-thumb">
            <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" /></a></div>
            <div>
              <div class="caption">
                <h4><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
                <p class="description"><?php echo $product['description']; ?></p>
                <?php if ($product['price']) { ?>
                <p class="price">
                  <?php if (!$product['special']) { ?>
                  <?php echo $product['price']; ?>
                  <?php } else { ?>
                  <span class="price-new"><?php echo $product['special']; ?></span> <span class="price-old"><?php echo $product['price']; ?></span>
                  <?php } ?>
                  <?php if ($product['tax']) { ?>
                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
                  <?php } ?>
                </p>
                <?php } ?>
                <?php if ($product['rating']) { ?>
                <div class="rating">
                  <?php for ($i = 1; $i <= 5; $i++) { ?>
                  <?php if ($product['rating'] < $i) { ?>
                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
                  <?php } else { ?>
                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
                  <?php } ?>
                  <?php } ?>
                </div>
                <?php } ?>
              </div>
             
            </div>
          </div>
        </div>
        <?php } ?>
      </div>
      <div class="row">
        <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
        <div class="col-sm-6 text-right"><?php echo $results; ?></div>
      </div>
      <?php } ?>
      <?php if (!$categories && !$products) { ?>
      <p><?php echo $text_empty; ?></p>
      <div class="buttons">
        <div class="pull-right"><a href="<?php echo $continue; ?>" class="btn btn-primary"><?php echo $button_continue; ?></a></div>
      </div>
      <?php } ?>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
    <hr>
   <div class="row">
        <?php if ($thumb) { ?>
        <div class="col-sm-2"><img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" title="<?php echo $heading_title; ?>" class="img-thumbnail" /></div>
        <?php } ?>
        <?php if ($description) { ?>
        <div class="col-sm-12"><?php echo $description; ?></div>
        <?php } ?>
      </div> 
</div>

            
<?php echo $footer; ?>
