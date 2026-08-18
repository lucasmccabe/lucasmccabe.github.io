# Drops pages from the build when their `active_pages` flag in _config.yml
# is explicitly false. Pages opt in via a `nav_id:` front matter key matching
# an entry under `active_pages`. Runs at post_read, before sitemap/feed
# generation, so excluded pages are left out of those too.
Jekyll::Hooks.register :site, :post_read do |site|
  active_pages = site.config['active_pages'] || {}

  site.pages.reject! do |page|
    nav_id = page.data['nav_id']
    nav_id && active_pages.key?(nav_id) && active_pages[nav_id] == false
  end
end
