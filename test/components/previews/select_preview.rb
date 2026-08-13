# @label Select
#
# - Preview: `test/components/previews/select_preview.rb`
# - Partial: `app/views/ui/_select.html.erb`
class SelectPreview < Lookbook::Preview
  layout "lookbook"

  # @label Default
  # @param size select { choices: [sm, md, lg] }
  def default(size: "md")
    render "ui/select", options: %w[Option\ 1 Option\ 2 Option\ 3], size: size
  end

  # @label Invalid
  # @param size select { choices: [sm, md, lg] }
  def invalid(size: "md")
    render "ui/select", options: %w[Option\ 1 Option\ 2], size: size, invalid: true
  end

  # @label Disabled
  # @param size select { choices: [sm, md, lg] }
  def disabled(size: "md")
    render "ui/select", options: %w[Option\ 1 Option\ 2], size: size, disabled: true
  end

  # @label All States
  def all_states
    render "ui/select_grid"
  end
end
