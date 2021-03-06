# coding: utf-8

# Support for displaying an array of strings formatted with word wrap.
class Array

  # Print out the array with word wrap.
  def puts_format_output_word_wrap(options = {})
    puts format_output_word_wrap(options).join("\n")
  end

  # Convert the array to a string with word wrap.
  # Returns: A string.
  def format_output_word_wrap(options = {})
    format_output_raw_word_wrap(options).join("\n")
  end

  # Convert the array to strings with word wrap.
  # Returns: An array of strings.
  def format_output_raw_word_wrap(options = {})
    result = []

    each do |item|
      result.concat(item.to_s.format_output_raw_word_wrap(options))
      result << ""
    end

    result
  end

end

# Support for displaying string data formatted with word wrap.
class String

  # Print out the string with word wrap.
  def puts_format_output_word_wrap(options = {})
    puts format_output_word_wrap(options)
  end

  # Convert the string to a string with bullet points.
  # Returns: A string.
  def format_output_word_wrap(options = {})
    format_output_raw_word_wrap(options).join("\n")
  end

  # Convert the string to an array of strings with word wrap.
  # Returns: An array of strings.
  # This method is a duplicate of a bullet point method with a new name.
  alias :format_output_raw_word_wrap :format_output_bullet_detail

end
