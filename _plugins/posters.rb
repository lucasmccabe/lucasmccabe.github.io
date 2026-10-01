require "digest"

# Liquid filters for posters (see the VOCABULARY note in assets/css/main.scss).
#
# {{ entry.title | poster_index: list, palette_size [, key [, canonical]] }} => palette position
# `list` is every entry of the list IN DISPLAY ORDER; `key` is the title field (default "title").
# Titles are ranked by hash and dealt like a shuffled deck (stable across builds). The list is
# then walked in order and a color matching either of the previous SEPARATION entries is
# bumped to the next palette color, so no two entries within SEPARATION places share one.
# A pinned entry (`poster_color`) keeps its color and earlier entries steer clear of it; nearby
# entries that pin the same color stay as pinned. Best-effort if the palette is tiny.
#
# `canonical` (optional) is the full list in its canonical order, for pages that show only part
# of it (About shows the selected works). Colors are first dealt over `canonical`, so an entry
# gets the same color on every page, and are then bumped on this page only where the subset
# creates a repeat. Without it the list is its own canonical list.
# Trade-off: a poster's color depends on the whole list and its order.
module PosterIndexFilter
  SEPARATION = 2

  def poster_index(title, publications, size, key = nil, canonical = nil)
    size = size.to_i
    return 1 if size < 1

    key = key.to_s.empty? ? "title" : key.to_s
    title = title.to_s
    entries = Array(publications)
    titles = entries.map { |p| p[key].to_s }
    unless titles.include?(title)
      ranked = (titles.uniq << title).sort_by { |t| [Digest::MD5.hexdigest(t), t] }
      return ranked.index(title) % size + 1
    end

    preferred = canonical ? deal(Array(canonical), key, size).first : nil
    deal(entries, key, size, preferred).last[titles.index(title)]
  end

  private

  # Deals colors to `entries` in order. Returns [color by title (first occurrence), colors by
  # position]. `preferred` (title => color) supplies each entry's starting color when given.
  def deal(entries, key, size, preferred = nil)
    titles = entries.map { |p| p[key].to_s }
    ranked = titles.uniq.sort_by { |t| [Digest::MD5.hexdigest(t), t] }
    base = ->(t) { ranked.index(t) % size + 1 }
    pinned = entries.map { |e| pinned_poster_index(e["poster_color"], size) }

    colors = []
    titles.each_with_index do |t, i|
      if pinned[i]
        colors << pinned[i]
        next
      end
      color = (preferred && preferred[t]) || base.(t)
      avoid = (1..SEPARATION).flat_map { |d| [(colors[i - d] if i - d >= 0), pinned[i + d]] }.compact
      size.times do
        break unless avoid.include?(color)

        color = color % size + 1
      end
      colors << color
    end

    by_title = {}
    titles.each_with_index { |t, i| by_title[t] ||= colors[i] }
    [by_title, colors]
  end

  # A pinned `poster_color` is a palette name (or a 1-based position); returns its position.
  def pinned_poster_index(value, size)
    return nil if value.nil? || value.to_s.empty?

    palette = @context.registers[:site].data["poster_palette"] || []
    by_name = palette.index { |pair| pair["name"] == value.to_s }
    return by_name + 1 if by_name

    n = value.to_s.to_i
    n.between?(1, size) ? n : nil
  end
end

# EXPERIMENT: the dot-grid glyph. To remove it: these filters, their calls in the includes and
# header, favicon.svg, and the "glyph" blocks in assets/css/main.scss.
#
# {{ text | poster_glyph [: css_class [, ghost [, min_on]]] }} => inline SVG: a 3x3 grid of
# circles with a random 2..6 "on" (hashed from `text`, so stable) and the rest at opacity
# `ghost` (default 0 = invisible). `css_class` defaults to "poster__glyph"; `min_on` forces at
# least that many dots on.
# {{ text | poster_glyph_favicon: bg, fg }} => the same glyph as a standalone tile for favicon.svg.
module PosterGlyphFilter
  def poster_glyph(title, css_class = nil, ghost = nil, min_on = nil)
    css_class = "poster__glyph" if css_class.to_s.empty?
    %(<svg class="#{css_class}" viewBox="0 0 9 9" aria-hidden="true" fill="currentColor">#{glyph_circles(title, ghost, min_on)}</svg>)
  end

  def poster_glyph_favicon(title, bg, fg)
    %(<svg xmlns="http://www.w3.org/2000/svg" viewBox="-2 -2 13 13">) +
      %(<rect x="-2" y="-2" width="13" height="13" rx="2.2" fill="#{bg}"/>) +
      %(<g fill="#{fg}">#{glyph_circles(title, nil, 5)}</g></svg>)
  end

  private

  def glyph_circles(title, ghost = nil, min_on = nil)
    bytes = Digest::MD5.hexdigest("glyph|#{title}").scan(/../).map { |b| b.to_i(16) }
    count = [2 + bytes[1] % 5, min_on.to_i].max
    on = (0..8).sort_by { |i| [bytes[2 + i], i] }.first(count)
    off_opacity = ghost.to_s.empty? ? 0 : ghost.to_f
    (0..8).map do |i|
      cx = i % 3 * 3 + 1.5
      cy = i / 3 * 3 + 1.5
      %(<circle cx="#{cx}" cy="#{cy}" r="1.05"#{on.include?(i) ? "" : %( opacity="#{off_opacity}")}/>)
    end.join
  end
end

Liquid::Template.register_filter(PosterIndexFilter)
Liquid::Template.register_filter(PosterGlyphFilter)
