module ApplicationHelper
  def render_date_picker(name:, value: nil, placeholder: "Pick a date")
    render "ui/date_picker", name: name, value: value, placeholder: placeholder
  end
end
