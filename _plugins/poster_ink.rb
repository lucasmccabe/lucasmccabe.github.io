# {{ bg_hex | poster_ink }} => the text color for a poster with that background: the background's
# own hue as a dark tint (OKLCH L 0.27) or a light tint (L 0.95), whichever contrasts more (WCAG).
# Used by the POSTER PALETTE block in assets/css/main.scss; a palette entry's own `text` overrides it.
module PosterInkFilter
  DARK_INK  = { l: 0.27, c: 0.055 }.freeze
  LIGHT_INK = { l: 0.95, c: 0.020 }.freeze

  def poster_ink(bg)
    _, _, hue = PosterInkFilter.to_oklch(bg.to_s)
    dark = PosterInkFilter.from_oklch(DARK_INK[:l], DARK_INK[:c], hue)
    light = PosterInkFilter.from_oklch(LIGHT_INK[:l], LIGHT_INK[:c], hue)
    PosterInkFilter.contrast(bg.to_s, dark) >= PosterInkFilter.contrast(bg.to_s, light) ? dark : light
  end

  # sRGB hex <-> OKLCH and WCAG contrast, as module functions so they can be tested.

  def self.linear(channel)
    c = channel / 255.0
    c <= 0.04045 ? c / 12.92 : ((c + 0.055) / 1.055)**2.4
  end

  def self.to_oklch(hex)
    r, g, b = hex.delete("#").scan(/../).map { |h| linear(h.to_i(16)) }
    l = Math.cbrt(0.4122214708 * r + 0.5363325363 * g + 0.0514459929 * b)
    m = Math.cbrt(0.2119034982 * r + 0.6806995451 * g + 0.1073969566 * b)
    s = Math.cbrt(0.0883024619 * r + 0.2817188376 * g + 0.6299787005 * b)
    lightness = 0.2104542553 * l + 0.7936177850 * m - 0.0040720468 * s
    a = 1.9779984951 * l - 2.4285922050 * m + 0.4505937099 * s
    bb = 0.0259040371 * l + 0.7827717662 * m - 0.8086757660 * s
    [lightness, Math.hypot(a, bb), Math.atan2(bb, a) * 180 / Math::PI % 360]
  end

  def self.from_oklch(lightness, chroma, hue)
    a = chroma * Math.cos(hue * Math::PI / 180)
    b = chroma * Math.sin(hue * Math::PI / 180)
    l = (lightness + 0.3963377774 * a + 0.2158037573 * b)**3
    m = (lightness - 0.1055613458 * a - 0.0638541728 * b)**3
    s = (lightness - 0.0894841775 * a - 1.2914855480 * b)**3
    rgb = [
      4.0767416621 * l - 3.3077115913 * m + 0.2309699292 * s,
      -1.2684380046 * l + 2.6097574011 * m - 0.3413193965 * s,
      -0.0041960863 * l - 0.7034186147 * m + 1.7076147010 * s
    ]
    "#" + rgb.map { |x| encode(x) }.join
  end

  def self.encode(value)
    v = value.clamp(0.0, 1.0)
    v = v <= 0.0031308 ? 12.92 * v : 1.055 * v**(1 / 2.4) - 0.055
    format("%02X", (v * 255).round)
  end

  def self.luminance(hex)
    r, g, b = hex.delete("#").scan(/../).map { |h| linear(h.to_i(16)) }
    0.2126 * r + 0.7152 * g + 0.0722 * b
  end

  def self.contrast(a, b)
    hi, lo = [luminance(a), luminance(b)].max, [luminance(a), luminance(b)].min
    (hi + 0.05) / (lo + 0.05)
  end
end

Liquid::Template.register_filter(PosterInkFilter)
