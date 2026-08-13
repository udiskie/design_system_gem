# @label Data Table
#
# - Preview: `test/components/previews/data_table_preview.rb`
# - Partial: `app/views/ui/_data_table.html.erb`
class DataTablePreview < Lookbook::Preview
  layout "lookbook"

  # @label Climate Data
  def climate_data
    render "ui/data_table",
      label: "Climate data",
      headers: [ "Max. Temp.", "Min. temp.", "Acc. Prec." ],
      rows: [ [ "19.9\u00B0C", "7.3\u00B0C", "43.7" ] ],
      columns: 3
  end

  # @label Multi Row
  def multi_row
    render "ui/data_table",
      headers: %w[Date Score Status],
      rows: [
        [ "2025-01-15", "82.3", "Good" ],
        [ "2025-02-15", "75.1", "Fair" ],
        [ "2025-03-15", "91.0", "Excellent" ]
      ],
      columns: 3
  end
end
