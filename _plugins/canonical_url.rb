require "yaml"

# {{ page.url | canonical_url }} => the page's address on the live site: `url` + `baseurl` from
# _config.yml + the path. Unlike `absolute_url`, it ignores `jekyll serve` replacing `url` with
# http://localhost:4000 in development, so links meant for other people (citations) stay correct.
module CanonicalUrlFilter
  def canonical_url(path)
    site = @context.registers[:site]
    path_to_config = File.join(site.source, "_config.yml")
    config = File.exist?(path_to_config) ? YAML.safe_load(File.read(path_to_config)) || {} : {}
    base = (config["url"].to_s.empty? ? site.config["url"] : config["url"]).to_s.chomp("/")
    prefix = (config["baseurl"] || site.config["baseurl"]).to_s.chomp("/")
    "#{base}#{prefix}/#{path.to_s.sub(%r{\A/}, "")}"
  end
end

Liquid::Template.register_filter(CanonicalUrlFilter)
