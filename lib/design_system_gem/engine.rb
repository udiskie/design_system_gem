# frozen_string_literal: true

module DesignSystemGem
  class Engine < ::Rails::Engine
    isolate_namespace DesignSystemGem

    # This gem doubles as its own dummy app in development, so when running
    # standalone the engine's root is the same directory as the app root.
    # Without this, Rails treats config/routes.rb as both the app's routes
    # file and the engine's own routes file and loads it twice, double-
    # drawing every route in it. Host apps consuming this gem as a
    # dependency don't share a root with it, so their own config/routes.rb
    # is unaffected -- but they still need this gem's config/routes.rb
    # auto-drawn (that's how they get the `mount Lookbook::Engine, at:
    # "/lookbook"` route above for free), so only clear the path when
    # DesignSystemGem is itself the running application.
    #
    # This has to run as an initializer, not directly in the class body:
    # the class body executes while this file is being required, which
    # (for both the standalone case and the host-app case) happens via
    # Bundler.require in config/application.rb -- before the host's
    # `class Application < Rails::Application` is even defined, so
    # `Rails.application` is still nil at that point and the check below
    # would always evaluate false.
    initializer "design_system_gem.standalone_routes_path", before: :add_routing_paths do
      paths["config/routes.rb"] = [] if Rails.application.class.module_parent == DesignSystemGem
    end

    initializer "design_system_gem.view_helpers" do
      ActiveSupport.on_load(:action_view) do
        include LucideRails::RailsHelper
      end
    end
  end
end
