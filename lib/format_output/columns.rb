# coding: utf-8

# Support for displaying an array formatted neatly.
# Output as columns starts with an array as input.
class Array

  # Print out the array with efficient columns.
  def puts_format_output_columns(page_width = ::FormatOutput.width)
    puts format_output_columns(page_width)
  end

  # Convert the array to a string with efficient columns.
  # Returns: A string.
  # Endemic Code Smells reek:FeatureEnvy -- false positive.
  def format_output_columns(page_width = ::FormatOutput.width)
    format_output_raw_columns(page_width).join("\n")
  end

  # Convert the array to strings with efficient columns.
  # Returns: An array of strings.
  def format_output_raw_columns(page_width = ::FormatOutput.width)
    builder = FormatOutput::ColumnBuilder.new(page_width)

    each {|item| builder.add(item)}

    builder.render
  end

  # Helper methods for the ColumnBuilder

  # Get the widest element of an array.
  # Returns: The width of the widest string in the array.
  def format_output_greatest_width
    max_by {|item| item.length}.length
  end

end
