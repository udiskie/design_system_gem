# @label Input
#
# - Preview: `test/components/previews/input_preview.rb`
# - Partial: `app/views/ui/_input.html.erb`
class InputPreview < Lookbook::Preview
  layout "lookbook"

  # @label Default
  # @param size select { choices: [sm, md, lg] }
  def default(size: "md")
    render "ui/input", placeholder: "Enter text...", size: size
  end

  # @label Invalid
  # @param size select { choices: [sm, md, lg] }
  def invalid(size: "md")
    render "ui/input", placeholder: "Invalid input", size: size, invalid: true
  end

  # @label Disabled
  # @param size select { choices: [sm, md, lg] }
  def disabled(size: "md")
    render "ui/input", placeholder: "Disabled input", size: size, disabled: true
  end

  # @label All States
  def all_states
    render "ui/input_grid"
  end
end
