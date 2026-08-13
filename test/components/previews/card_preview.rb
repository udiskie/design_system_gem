# @label Card
#
# - Preview: `test/components/previews/card_preview.rb`
# - Partial: `app/views/ui/_card.html.erb`
class CardPreview < Lookbook::Preview
  layout "lookbook"

  # @label Default
  def default
    render "ui/card_default"
  end
end
