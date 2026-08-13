# @label Toast
#
# - Preview: `test/components/previews/toast_preview.rb`
# - Partial: `app/views/ui/_toast.html.erb`
class ToastPreview < Lookbook::Preview
  layout "lookbook"

  # @label Success
  # @param size select { choices: [sm, md, lg] }
  def success(size: "md")
    render "ui/toast", text: "Saved successfully", variant: "success", size: size
  end

  # @label Warning High
  # @param size select { choices: [sm, md, lg] }
  def warning_high(size: "md")
    render "ui/toast", text: "Something went wrong", variant: "warning-high", size: size
  end

  # @label Warning Medium
  # @param size select { choices: [sm, md, lg] }
  def warning_medium(size: "md")
    render "ui/toast", text: "Please review your input", variant: "warning-medium", size: size
  end

  # @label Neutral
  # @param size select { choices: [sm, md, lg] }
  def neutral(size: "md")
    render "ui/toast", text: "Processing your request", variant: "neutral", size: size
  end
end
