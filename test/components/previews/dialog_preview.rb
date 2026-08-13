# @label Dialog
#
# - Preview: `test/components/previews/dialog_preview.rb`
# - Partial: `app/views/ui/_dialog.html.erb`
class DialogPreview < Lookbook::Preview
  layout "lookbook"

  # @label Default
  def default
    render "ui/dialog_default"
  end

  # @label All Sizes
  def all_sizes
    render "ui/dialog_grid"
  end
end
