# @label Drawer
#
# - Preview: `test/components/previews/drawer_preview.rb`
# - Partial: `app/views/ui/_drawer.html.erb`
#
# Persistent items: the drawer-content shell and the bold title div.
# Everything else is passed via the yield block.
#
# Props:
#   title:     required — bold title rendered inside the drawer
#   direction: "top" | "bottom" | "right" | "left"   — default "right"
#   id:        optional — used by `data-drawer-trigger="<id>"`
class DrawerPreview < Lookbook::Preview
  layout "lookbook"

  # @label Default
  def default
    render "ui/drawer_default"
  end

  # @label Directions
  def directions
    render "ui/drawer_directions"
  end
end
