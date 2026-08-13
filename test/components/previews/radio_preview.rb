# @label Radio
#
# - Preview: `test/components/previews/radio_preview.rb`
# - Partial: `app/views/ui/_radio.html.erb`
class RadioPreview < Lookbook::Preview
  layout "lookbook"

  # @label Default
  # @param size select { choices: [sm, md, lg] }
  def default(size: "md")
    render "ui/radio", label: "Option A", name: "preview_group", size: size
  end

  # @label Checked
  # @param size select { choices: [sm, md, lg] }
  def checked(size: "md")
    render "ui/radio", label: "Option A", name: "preview_group", size: size, checked: true
  end

  # @label Disabled
  # @param size select { choices: [sm, md, lg] }
  def disabled(size: "md")
    render "ui/radio", label: "Disabled option", name: "preview_group", size: size, disabled: true
  end

  # @label Group
  def group
    render "ui/radio_group"
  end
end
