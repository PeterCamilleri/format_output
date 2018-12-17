# coding: utf-8

# Support for displaying an array formatted neatly.
# Output as bullet points starts with an array as input.
class Array

  # Print out the array as bullet points.
  def puts_format_output_bullets(page_width = 80)
    puts format_output_bullets(page_width)
  end

  # Convert the array to strings with bullet points.
  # Returns: A string.
  # Endemic Code Smells  :reek:FeatureEnvy -- false positive.
  def format_output_bullets(page_width = 80)
    return "" if empty?

    builder = FormatOutput::BulletPointBuilder.new(page_width)

    each {|pair| builder.add(*pair.format_output_prepare_bullet_data)}

    builder.render.join("\n")
  end

  # This method is a duplicate of a column method with a new name.
  alias :format_output_bullet_detail :format_output_raw_columns

  # Get data ready for being in a bullet point.
  def format_output_prepare_bullet_data
    if length < 2
      ["*", self[0]]
    else
      self
    end
  end

end
