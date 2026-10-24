<?php
class ControllerCommonHome extends Controller {
	public function index() {
		$this->document->setTitle($this->config->get('config_meta_title'));
		$this->document->setDescription($this->config->get('config_meta_description'));
		$this->document->setKeywords($this->config->get('config_meta_keyword'));

		if (isset($this->request->get['route'])) {
			$this->document->addLink($this->config->get('config_url'), 'canonical');
		}

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		// SvetLamp theme: the "Рекомендуем" block
		$data['sl_recommended'] = $this->getRecommended();

		$this->response->setOutput($this->load->view('common/home', $data));
	}

	// Products of the "Рекомендуемые" (featured) modules placed on the home page layout.
	protected function getRecommended() {
		$this->load->model('design/layout');
		$this->load->model('extension/module');
		$this->load->model('catalog/product');
		$this->load->model('tool/image');

		$layout_id = $this->model_design_layout->getLayout('common/home');

		$products = array();
		$seen = array();

		foreach ($this->model_design_layout->getLayoutModules($layout_id, 'content_top') as $module) {
			$part = explode('.', $module['code']);

			if ($part[0] != 'featured' || !isset($part[1])) {
				continue;
			}

			$setting = $this->model_extension_module->getModule($part[1]);

			if (!$setting || empty($setting['status']) || empty($setting['product'])) {
				continue;
			}

			$limit = !empty($setting['limit']) ? (int)$setting['limit'] : 4;
			$width = !empty($setting['width']) ? (int)$setting['width'] : 300;
			$height = !empty($setting['height']) ? (int)$setting['height'] : 300;

			foreach (array_slice($setting['product'], 0, $limit) as $product_id) {
				if (isset($seen[$product_id])) {
					continue;
				}

				$product_info = $this->model_catalog_product->getProduct($product_id);

				if (!$product_info) {
					continue;
				}

				$seen[$product_id] = true;

				if ($product_info['image']) {
					$thumb = $this->model_tool_image->resize($product_info['image'], $width, $height);
				} else {
					$thumb = $this->model_tool_image->resize('placeholder.png', $width, $height);
				}

				$products[] = array(
					'product_id' => $product_info['product_id'],
					'name'       => $product_info['name'],
					'caption'    => $product_info['manufacturer'],
					'thumb'      => $thumb,
					'tags'       => $this->getTags($product_info),
					'href'       => $this->url->link('product/product', 'product_id=' . $product_info['product_id'])
				);
			}
		}

		return $products;
	}

	// Tags are the values of the product's attributes (цоколь, мощность, температура…), four at most.
	protected function getTags($product_info) {
		$tags = array();

		foreach ($this->model_catalog_product->getProductAttributes($product_info['product_id']) as $attribute_group) {
			foreach ($attribute_group['attribute'] as $attribute) {
				$text = trim(strip_tags(html_entity_decode($attribute['text'], ENT_QUOTES, 'UTF-8')));

				if ($text !== '' && utf8_strlen($text) <= 24 && !in_array(htmlspecialchars($text, ENT_QUOTES, 'UTF-8'), $tags)) {
					$tags[] = htmlspecialchars($text, ENT_QUOTES, 'UTF-8');
				}

				if (count($tags) == 4) {
					return $tags;
				}
			}
		}

		// No attributes yet: show the model so the card is not empty
		if (!$tags && $product_info['model']) {
			$tags[] = $product_info['model'];
		}

		return $tags;
	}
}
