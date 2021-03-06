# coding: utf-8

# Support for displaying an array formatted neatly.
# Output as bullet points starts with an array as input.
class Array

  # Print out the array as bullet points.
  def puts_format_output_bullets(options = {})
    puts format_output_bullets(options)
  end

  # Convert the array to a string with bullet points.
  # Returns: A string.
  def format_output_bullets(options = {})
    format_output_raw_bullets(options).join("\n")
  end

  # Convert the array to strings with bullet points.
  # Returns: An array of strings.
  def format_output_raw_bullets(options = {})
    return [""] if empty?

    builder = FormatOutput::BulletPointBuilder.new(options)

    each {|pair| builder.add(*pair.format_output_prepare_bullet_detail)}

    builder.render
  end

  # Helper methods for the BulletPointBuilder

  # This method is a duplicate of a column method with a new name.
  alias :format_output_bullet_detail :format_output_raw_columns

  # Get data ready for being in a bullet point.
  def format_output_prepare_bullet_detail
    if length < 2
      ["*", self[0]]
    else
      self
    end
  end

end

# Support for displaying data formatted neatly.
class Object

  # Create a bullet point description from this object.
  # Returns: An array of strings.
  def format_output_bullet_detail(options = {})
    self.to_s.format_output_bullet_detail(options)
  end

  # Get data ready for being in a bullet point.
  def format_output_prepare_bullet_detail
    ["*", self]
  end

end

# Support for displaying nothing formatted neatly.
class NilClass

  # Create a bullet point description from nothing.
  # Returns: An array of nothing.
  def format_output_bullet_detail(_options = nil)
    []
  end

end

# Support for displaying string data formatted in bullet points.
class String

  # Create a bullet point description from this string.
  # Returns: An array of strings.
  def format_output_bullet_detail(options = {})
    body = ::FormatOutput.width(options)
    pad  = ::FormatOutput.pad(options)

    do_format_output_bullet_detail(split(' ').each, body, pad)
  end

  # Do the formatting legwork.
  # Returns: An array of strings.
  def do_format_output_bullet_detail(input, body, pad)
    buffer, build, empty = [], "", false

    # Grab "words" of input, splitting off lines as needed.
    # Note: This loop exits when input.next runs out of data.
    loop do
      build = build.format_output_split_if_over(buffer, body, pad, input.next)
                   .format_output_split_if_huge(buffer, body, pad)

      empty = build.empty?
    end

    unless empty
      buffer << pad + build
    end

    buffer
  end

  # Split if adding a word goes over a little.
  # Note: self is the build string from do_format_output_bullet_detail.
  # Returns: A string.
  def format_output_split_if_over(buffer, body, pad, word)
    word.prepend(" ") unless empty? #Add a space except for the first word.

    word_len = word.length

    if (length + word_len) >= body && word_len < body
      buffer << pad + self    # Line done, add to buffer.
      word.lstrip             # Start of a new line, remove the leading space.
    else
      self + word
    end
  end

  # Split up a overlong blob of text.
  # Note: self is the result string from format_output_split_if_over.
  # Returns: A string.
  def format_output_split_if_huge(buffer, body, pad)

    # Slice away any excess text into lines in the buffer.
    while length >= body
      buffer << pad + slice!(0, body)
    end

    self
  end
end
