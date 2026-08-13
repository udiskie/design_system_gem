# @label Field
#
# - Preview: `test/components/previews/field_preview.rb`
# - Partial: `app/views/ui/_field.html.erb`
class FieldPreview < Lookbook::Preview
  layout "lookbook"

  # @label Default
  # @param label text
  # @param value text
  def default(label: "Location name", value: "Almonds Portugal BM 1")
    render "ui/field", label: label, value: value
  end

  # @label With Badge Value
  def with_badge
    render "ui/field_with_badge"
  end

  # @label Grid
  def grid
    render "ui/field_grid"
  end
end
