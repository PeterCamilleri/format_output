# coding: utf-8

# Print out data in neat columns.
module FormatOutput

  # A class to build columns for display.
  class ColumnBuilder

    # Prepare a blank page.
    def initialize(options)
      @body        = ::FormatOutput.body(options)
      @pad         = ::FormatOutput.pad(options)
      @page_data   = []
    end

    # Add an item to this page.
    # Returns: The number of items that did not fit in the page.
    def add(raw_item)
      item = raw_item.to_s
      fail "Item too large to fit." unless item.length < @body

      if (column = find_next_column)
        @page_data[column] << item
      else
        @page_data << [item]
      end

      adjust_configuration
    end

    # Render the page as an array of strings.
    def render
      results, column_widths = [], get_column_widths

      rows.times { |row_index| results << render_row(row_index, column_widths)}

      @page_data.clear
      results
    end

    private

    # Get the widths of all columns
    def get_column_widths
      @page_data.map {|column| column.format_output_greatest_width}
    end

    # Render a single row of data.
    # Returns: A string.
    def render_row(row_index, widths)
      @pad + @page_data.each_with_index.map do |column, index|
        column[row_index].to_s.ljust(widths[index])
      end.join(" ")
    end

    # Make sure the page fits within its boundaries.
    def adjust_configuration
      while total_width >= @body
        add_a_row
      end
    end

    # Add a row to the page, moving items as needed.
    def add_a_row
      new_rows = rows + 1
      pool, @page_data = @page_data.flatten, []

      until pool.empty?
        @page_data << pool.shift(new_rows)
      end
    end

    # Compute the total width of all of the columns.
    # Returns: The sum of the widths of the widest items of each column plus
    #          a space between each of those columns.
    def total_width
      if empty?
        0
      else
        #The starting point, @page_data.length-1, represents the spaces needed
        #between the columns. So N columns means N-1 spaces.
        @page_data.inject(@page_data.length-1) do |sum, column|
          sum + column.format_output_greatest_width
        end
      end
    end

    # Does the data fit on the page?
    def fits?
      total_width < @body
    end

    # How many rows are currently in this page?
    def rows
      empty? ? 0 : @page_data[0].length
    end

    # Is this page empty?
    def empty?
      @page_data.empty?
    end

    # Which column will receive the next item?
    # Returns: The index of the first non-filled column or nil if none found.
    def find_next_column
      (1...(@page_data.length)).each do |index|
        if @page_data[index].length < @page_data[index-1].length
          return index
        end
      end

      nil
    end
  end

end
