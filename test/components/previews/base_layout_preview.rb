# @label Base Layout
#
# - Preview: `test/components/previews/base_layout_preview.rb`
# - Partial: `app/views/ui/_base_layout.html.erb`
class BaseLayoutPreview < Lookbook::Preview
  layout "lookbook"

  # @label Default
  # @param title text
  # @param icon text
  def default(title: "Dashboard", icon: "house")
    render "ui/base_layout",
      title: title,
      icon: icon,
      active_controller: "locations_dashboard",
      sidebar_items: [
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
      sidebar_footer_items: [
        { label: "Terms and conditions", icon: "scroll-text", href: "#" },
        { label: "FAQ", icon: "message-circle-question", href: "#" }
      ],
      user_name: "ivan",
      user_email: "ivan@design-system-gem.test",
      edit_profile_url: "#",
      logout_url: "#"
  end
end
