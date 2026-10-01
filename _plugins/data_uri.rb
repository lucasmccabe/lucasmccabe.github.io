require "base64"

# {{ "assets/img/favicon-32.png" | data_uri }} => a data: URI holding that file (path relative to the
# site source). Used to inline the favicon so the tab icon needs no network request.
module DataUriFilter
  MIME_TYPES = { ".png" => "image/png", ".svg" => "image/svg+xml", ".ico" => "image/x-icon" }.freeze

  def data_uri(path)
    file = File.join(@context.registers[:site].source, path.to_s.sub(%r{\A/}, ""))
    mime = MIME_TYPES.fetch(File.extname(file).downcase) { raise ArgumentError, "data_uri: unsupported type #{file}" }
    "data:#{mime};base64,#{Base64.strict_encode64(File.binread(file))}"
  end
end

Liquid::Template.register_filter(DataUriFilter)
