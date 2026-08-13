# @label Icon Button
#
# - Preview: `test/components/previews/icon_button_preview.rb`
# - Partial: `app/views/ui/_icon_button.html.erb`
class IconButtonPreview < Lookbook::Preview
  layout "lookbook"

  # @label Outline Square
  # @param size select { choices: [sm, md, lg] }
  def outline_square(size: "sm")
    render "ui/icon_button_preview", variant: "outline", shape: "square", size: size, icon_name: "arrow-up-right"
  end

  # @label Tinted Round
  # @param size select { choices: [sm, md, lg] }
  def tinted_round(size: "md")
    render "ui/icon_button_preview", variant: "tinted", shape: "round", size: size, icon_name: "ellipsis-vertical"
  end

  # @label Ghost Square
  # @param size select { choices: [sm, md, lg] }
  def ghost_square(size: "sm")
    render "ui/icon_button_preview", variant: "ghost", shape: "square", size: size, icon_name: "settings"
  end

  # @label Disabled
  def disabled
    render "ui/icon_button_preview", variant: "outline", shape: "square", size: "sm", icon_name: "arrow-up-right", disabled: true
  end

  # @label All Variants
  def all_variants
    render "ui/icon_button_grid"
  end
end
