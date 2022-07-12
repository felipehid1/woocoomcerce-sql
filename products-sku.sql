SELECT post.post_title, metaSku.meta_value AS sku, metaPrice.meta_value AS price, metaPriceRegular.meta_value AS priceregular, terms.categories
FROM wp_posts AS post
LEFT JOIN wp_postmeta AS metaSku ON post.ID = metaSku.post_id AND metaSku.meta_key = '_sku'
LEFT JOIN wp_postmeta AS metaPrice ON post.ID = metaPrice.post_id AND metaPrice.meta_key = '_price'
LEFT JOIN wp_postmeta AS metaPriceRegular ON post.ID = metaPriceRegular.post_id AND metaPriceRegular.meta_key = '_regular_price'
LEFT JOIN (
    SELECT wtr.object_id, GROUP_CONCAT(wp_terms.name ORDER BY wp_terms.term_order ASC SEPARATOR ', ') AS categories
    FROM wp_term_relationships wtr join wp_terms on wtr.term_taxonomy_id = wp_terms.term_id
    GROUP BY wtr.object_id
) terms on post.ID = terms.object_id
WHERE post.post_type = 'product'
