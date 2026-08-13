# @label Typography
#
# - Preview: `test/components/previews/typography_preview.rb`
# - Partials: `app/views/ui/_heading.html.erb`, `app/views/ui/_paragraph.html.erb`, `app/views/ui/_link.html.erb`
class TypographyPreview < Lookbook::Preview
  layout "lookbook"

  # @label Headings
  def headings
    render "ui/headings_grid"
  end

  # @label Paragraph
  # @param variant select { choices: [~, muted] }
  # @param size select { choices: [~, sm, md, lg] }
  def paragraph(variant: nil, size: nil)
    render "ui/paragraph", text: "This is body text. It demonstrates the paragraph styling.", variant: variant, size: size
  end

  # @label Link
  # @param variant select { choices: [~, destructive, underline] }
  # @param size select { choices: [~, sm, md, lg] }
  def link(variant: nil, size: nil)
    render "ui/link", text: "Example link", href: "#", variant: variant, size: size
  end

  # @label All Typography
  def all
    render "ui/typography_grid"
  end
end
