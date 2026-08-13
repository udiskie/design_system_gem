class DatePickerPreview < Lookbook::Preview
  layout "lookbook"

  # @label Default (no value)
  def default
    render "ui/date_picker", name: "date", value: nil
  end

  # @label With value
  def with_value
    render "ui/date_picker", name: "date", value: "2024-05-30"
  end

  # @label Custom placeholder
  def custom_placeholder
    render "ui/date_picker", name: "date", value: nil, placeholder: "Select a date..."
  end
end
