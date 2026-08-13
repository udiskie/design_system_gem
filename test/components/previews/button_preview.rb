# @label Button
#
# - Preview: `test/components/previews/button_preview.rb`
# - Partial: `app/views/ui/_button.html.erb`
class ButtonPreview < Lookbook::Preview
  layout "lookbook"

  # @label Primary
  # @param size select { choices: [sm, md, lg] }
  def primary(size: "md")
    render "ui/button", text: "Primary", variant: "primary", size: size
  end

  # @label Secondary
  # @param size select { choices: [sm, md, lg] }
  def secondary(size: "md")
    render "ui/button", text: "Secondary", variant: "secondary", size: size
  end

  # @label Outline
  # @param size select { choices: [sm, md, lg] }
  def outline(size: "md")
    render "ui/button", text: "Outline", variant: "outline", size: size
  end

  # @label Destructive
  # @param size select { choices: [sm, md, lg] }
  def destructive(size: "md")
    render "ui/button", text: "Delete", variant: "destructive", size: size
  end

  # @label Disabled
  # @param size select { choices: [sm, md, lg] }
  def disabled(size: "md")
    render "ui/button", text: "Disabled", variant: "primary", size: size, disabled: true
  end

  # @label All Variants
  def all_variants
    render "ui/button_grid"
  end
end
