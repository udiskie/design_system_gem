# @label Sidebar
#
# - Preview: `test/components/previews/sidebar_preview.rb`
# - Partials: `app/views/ui/_sidebar.html.erb`, `app/views/ui/_sidebar_menu_item.html.erb`
#
# Props:
#   logo: true | false                — default true; set false to omit the built-in
#                                        logo image (or render "ui/sidebar" with a block
#                                        to supply a custom brand mark instead)
#
# footer_items entries accept { label:, icon:, href:, active:, method: } — pass
# method: (e.g. :delete) to render a button_to (e.g. sign out) instead of a link.
class SidebarPreview < Lookbook::Preview
  layout "lookbook"

  # @label Default
  # @param logo toggle
  def default(logo: true)
    render "ui/sidebar",
      active_controller: "locations_dashboard",
      logo: logo,
      items: [
        { label: "Dashboard", icon: "house", href: "#", controller: "locations_dashboard" },
        { label: "Alerts", icon: "triangle-alert", href: "#", controller: "alerts" },
        { label: "Notes", icon: "notebook-pen", href: "#", controller: "notes" },
        { label: "Map", icon: "earth", href: "#", controller: "maps" },
        { label: "Regional Data", icon: "circle-dollar-sign", href: "#", controller: "regional_data" },
        { label: "Reports", icon: "file-text", href: "#", controller: "reports" },
        { label: "Score Benchmark", icon: "chart-column", href: "#", controller: "benchmarking" },
        { label: "Agronomical Advisory", icon: "sheet", href: "#", controller: "agronomical_advisory" },
        { label: "Irrigation Planner", icon: "droplets", href: "#", controller: "irrigation" },
        { label: "Portfolio", icon: "briefcase-business", href: "#", controller: "portfolio" },
        { label: "Backoffice", icon: "building", href: "#", controller: "backoffice" }
      ],
      footer_items: [
        { label: "Terms and conditions", icon: "scroll-text", href: "#" },
        { label: "FAQ", icon: "message-circle-question", href: "#" }
      ],
      user_name: "ivan",
      user_email: "ivan@design-system-gem.test"
  end

  # @label Custom Logo
  #
  # Demonstrates passing a block to render a custom brand mark in place of the
  # default logo image.
  def custom_logo
    render "ui/sidebar_custom_logo"
  end

  # @label With Layout (mobile)
  def with_layout
    render template: "ui/previews/sidebar_layout"
  end

  # @label Menu Item
  # @param active toggle
  def menu_item(active: false)
    render "ui/sidebar_menu_item",
      label: "Dashboard",
      icon: "house",
      href: "#",
      active: active
  end
end
