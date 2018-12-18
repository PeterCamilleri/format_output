# coding: utf-8

# Support for displaying an array of strings formatted with word wrap.
class Array

  # Print out the array with word wrap.
  def puts_format_output_word_wrap(page_width = ::FormatOutput.page_width)
    puts format_output_word_wrap(page_width).join("\n")
  end

  # Convert the array to a string with bullet points.
  # Returns: A string.
  def format_output_word_wrap(page_width = ::FormatOutput.page_width)
    format_output_raw_word_wrap(page_width).join("\n")
  end

  # Returns: An array of strings.
  # This method is a duplicate of a bullet point method with a new name.
  def format_output_raw_word_wrap(page_width = ::FormatOutput.page_width)
    result = []

    each do |item|
      result.concat(item.to_s.format_output_raw_word_wrap(page_width))
      result << ""
    end

    result
  end

end

# Support for displaying string data formatted with word wrap.
class String

  # Print out the string with word wrap.
  def puts_format_output_word_wrap(page_width = ::FormatOutput.page_width)
    puts format_output_word_wrap(page_width)
  end

  # Convert the string to a string with bullet points.
  # Returns: A string.
  def format_output_word_wrap(page_width = ::FormatOutput.page_width)
    format_output_raw_word_wrap(page_width).join("\n")
  end

  # Convert the string to an array of strings with word wrap.
  # Returns: An array of strings.
  # This method is a duplicate of a bullet point method with a new name.
  alias :format_output_raw_word_wrap :format_output_bullet_detail

end
