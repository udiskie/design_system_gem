# @label Checkbox
#
# - Preview: `test/components/previews/checkbox_preview.rb`
# - Partial: `app/views/ui/_checkbox.html.erb`
class CheckboxPreview < Lookbook::Preview
  layout "lookbook"

  # @label Default
  # @param size select { choices: [sm, md, lg] }
  # @param checked toggle
  def default(size: "md", checked: false)
    render "ui/checkbox", label: "Accept terms", size: size, checked: checked
  end

  # @label Checked
  # @param size select { choices: [sm, md, lg] }
  def checked(size: "md")
    render "ui/checkbox", label: "Accept terms", size: size, checked: true
  end

  # @label Disabled
  # @param size select { choices: [sm, md, lg] }
  def disabled(size: "md")
    render "ui/checkbox", label: "Disabled option", size: size, disabled: true
  end
end
