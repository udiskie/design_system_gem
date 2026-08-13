require "base64"

class ShowcaseController < ApplicationController
  layout "showcase"

  def index
    gem_root = DesignSystemGem::Engine.root

    raw_css = File.read(gem_root.join("app/assets/builds/design_system_gem.css"))

    latin_path = gem_root.join("app/assets/fonts/manrope/manrope-variable-latin.woff2")
    latin_b64  = Base64.strict_encode64(File.binread(latin_path))
    latin_uri  = "data:font/woff2;base64,#{latin_b64}"

    @css = raw_css.gsub(
      "url('manrope/manrope-variable-latin.woff2') format('woff2')",
      "url('#{latin_uri}') format('woff2')"
    )
  end
end
