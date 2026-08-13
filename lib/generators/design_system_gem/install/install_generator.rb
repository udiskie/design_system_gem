require "rails/generators"

module DesignSystemGem
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Adds design_system_gem stylesheet and CLAUDE.md guidance to the host app"

      def inject_stylesheet
        layout = "app/views/layouts/application.html.erb"
        return unless File.exist?(layout)

        if File.read(layout).include?("design_system_gem")
          say "  stylesheet already present in #{layout}", :yellow
        else
          inject_into_file layout, before: "</head>" do
            %(    <%= stylesheet_link_tag "design_system_gem" %>\n)
          end
          say "  injected stylesheet_link_tag into #{layout}", :green
        end
      end

      def mount_lookbook
        routes = "config/routes.rb"
        return unless File.exist?(routes)

        if File.read(routes).include?("lookbook")
          say "  Lookbook already mounted in #{routes}", :yellow
        else
          inject_into_file routes, after: "Rails.application.routes.draw do\n" do
            <<~RUBY
                if Rails.env.development?
                  mount Lookbook::Engine, at: "/lookbook"
                end

            RUBY
          end
          say "  mounted Lookbook at /lookbook (development only)", :green
        end
      end

      def append_claude_md
        claude_md = "CLAUDE.md"
        marker    = "## Design System Gem"

        if File.exist?(claude_md) && File.read(claude_md).include?(marker)
          say "  CLAUDE.md already contains design system section", :yellow
          return
        end

        append_to_file claude_md, claude_md_content
        say "  appended design system section to CLAUDE.md", :green
      end

      private

      def claude_md_content
        <<~MD

          #{"-" * 66}

          ## Design System Gem

          UI components are provided by the `design_system_gem` gem.
          Do not write custom HTML for anything a gem component already covers.

          ### Viewing available components

          Start the dev server and open:
            http://localhost:3000/lookbook

          Every component is documented there with its render call and locals.

          ### Render pattern

          ```erb
          <%= render "ui/landing_page_components/COMPONENT_NAME",
                local_name: value %>
          ```

          ### Component inventory

          | Partial | Key locals |
          |---|---|
          | `_navbar` | — |
          | `_hero` | — |
          | `_inner_page_hero` | `title`, `description`, `cta_text`, `cta_url`, `image_src`, `image_alt` |
          | `_solutions_section` | `title`, `subtitle_texts`, `cards`, `reversed`, `id` |
          | `_solution_card` | `icon_paths`, `title`, `description`, `url` |
          | `_insights_section` | — |
          | `_insight_card` | `image_src`, `image_alt`, `title`, `description`, `url` |
          | `_custom_data_section` | — |
          | `_contact_section` | — |
          | `_partners_marquee` | — |
          | `_footer` | — |

          ### Rules

          - Never recreate a component inline. If a variant is needed,
            add it to the gem.
          - Every HTML `id` attribute must be unique in the rendered page.
            Partials accept `id:` as a local — callers must pass distinct
            values when rendering the same partial more than once.
          - The stylesheet is `design_system_gem.css` — already
            injected into `app/views/layouts/application.html.erb` by the
            install generator. Do not add it again.
        MD
      end
    end
  end
end
