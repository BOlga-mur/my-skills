<?php
// SvetLamp: buttons and tiles find the shop's category by its name.
// When no category matches, the link opens the shop search for that word, so no link is ever empty.
if (!function_exists('sl_key')) {
	function sl_key($name) {
		$name = html_entity_decode($name, ENT_QUOTES, 'UTF-8');
		// "Люстры (12)": the header adds product counts when they are switched on in the settings
		$name = preg_replace('/\s*\(\d+\)\s*$/u', '', $name);
		$name = utf8_strtolower(trim($name));
		$name = str_replace('ё', 'е', $name);

		return preg_replace('/\s+/u', ' ', $name);
	}

	// Header categories: top menu categories with their children.
	function sl_category_map($categories) {
		$map = array();

		foreach ((array)$categories as $category) {
			$map[sl_key($category['name'])] = $category['href'];

			if (!empty($category['children'])) {
				foreach ($category['children'] as $child) {
					$key = sl_key($child['name']);

					if (!isset($map[$key])) {
						$map[$key] = $child['href'];
					}
				}
			}
		}

		return $map;
	}

	// $names: the label first, then other names the category may have in the shop.
	// $fallback: where to go when nothing matches; the shop search for the label by default.
	function sl_link($map, $search, $names, $fallback = null) {
		$names = (array)$names;
		$keys = array_map('sl_key', $names);

		foreach ($keys as $key) {
			if (isset($map[$key])) {
				return $map[$key];
			}
		}

		// "Люстры и потолочные светильники" still counts as "люстры", but a word must start where the name does
		foreach ($keys as $key) {
			foreach ($map as $name => $href) {
				if (preg_match('/(^|[\s,(«"-])' . preg_quote($key, '/') . '/u', $name)) {
					return $href;
				}
			}
		}

		if ($fallback !== null) {
			return $fallback;
		}

		return $search . rawurlencode($names[0]);
	}

	// Category name without the product count, for display.
	function sl_name($name) {
		return preg_replace('/\s*\(\d+\)\s*$/u', '', $name);
	}
}
