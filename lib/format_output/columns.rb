# coding: utf-8

# Support for displaying an array formatted neatly.
# Output as columns starts with an array as input.
class Array

  # Print out the array with efficient columns.
  def puts_format_output_columns(width = nil, left_margin = nil)
    puts format_output_columns(width, left_margin)
  end

  # Convert the array to a string with efficient columns.
  # Returns: A string.
  # Endemic Code Smells reek:FeatureEnvy -- false positive.
  def format_output_columns(width = nil, left_margin = nil)
    format_output_raw_columns(width, left_margin).join("\n")
  end

  # Convert the array to strings with efficient columns.
  # Returns: An array of strings.
  def format_output_raw_columns(width = nil, left_margin = nil)
    builder = FormatOutput::ColumnBuilder.new(width, left_margin)

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
