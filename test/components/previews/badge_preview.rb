# @label Badge
#
# - Preview: `test/components/previews/badge_preview.rb`
# - Partial: `app/views/ui/_badge.html.erb`
class BadgePreview < Lookbook::Preview
  layout "lookbook"

  # @label Warning High
  # @param size select { choices: [sm, md, lg] }
  def warning_high(size: "sm")
    render "ui/badge", text: "Warning High: 133", variant: "warning-high", size: size
  end

  # @label Warning Medium
  # @param size select { choices: [sm, md, lg] }
  def warning_medium(size: "sm")
    render "ui/badge", text: "Warning Medium", variant: "warning-medium", size: size
  end

  # @label Warning Low
  # @param size select { choices: [sm, md, lg] }
  def warning_low(size: "sm")
    render "ui/badge", text: "Warning Low", variant: "warning-low", size: size
  end

  # @label Success
  # @param size select { choices: [sm, md, lg] }
  def success(size: "sm")
    render "ui/badge", text: "Success: Fruit development", variant: "success", size: size
  end

  # @label Ready
  # @param size select { choices: [sm, md, lg] }
  def ready(size: "sm")
    render "ui/badge", text: "Ready: Harvesting", variant: "ready", size: size
  end

  # @label Outline
  # @param size select { choices: [sm, md, lg] }
  def outline(size: "sm")
    render "ui/badge", text: "Outline: Flowering", variant: "outline", size: size
  end

  # @label Neutral
  # @param size select { choices: [sm, md, lg] }
  def neutral(size: "sm")
    render "ui/badge", text: "Neutral: 16.23 mm", variant: "neutral", size: size
  end

  # @label Score
  # @param size select { choices: [sm, md, lg] }
  def score(size: "sm")
    render "ui/badge", text: "Score: 80.23", variant: "score", size: size
  end

  # @label Disabled
  # @param size select { choices: [sm, md, lg] }
  def disabled(size: "sm")
    render "ui/badge", text: "Disabled: 05-06-2025", variant: "disabled", size: size
  end

  # @label All Variants
  # @display grid true
  def all_variants
    render "ui/badge_grid"
  end
end
