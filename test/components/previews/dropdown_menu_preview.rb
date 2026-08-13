# @label Dropdown Menu
#
# - Preview: `test/components/previews/dropdown_menu_preview.rb`
# - Partial: `app/views/ui/_dropdown_menu.html.erb`
#
# Props:
#   side:  "bottom" | "top"                 — default "bottom"
#   align: "start" | "center" | "end"       — default "end"
class DropdownMenuPreview < Lookbook::Preview
  layout "lookbook"

  # @label Default
  def default
    render "ui/dropdown_menu_default"
  end

  # @label With Destructive Item
  def with_destructive
    render "ui/dropdown_menu_destructive"
  end

  # @label Bottom And Top
  def bottom_and_top
    render "ui/dropdown_menu_sides"
  end
end
