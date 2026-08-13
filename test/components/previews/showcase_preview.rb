class ShowcasePreview < Lookbook::Preview
  layout "lookbook"

  # @label All components
  def all
    render template: "showcase/index"
  end
end
