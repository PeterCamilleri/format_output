# coding: utf-8

require_relative "format_output/columns"
require_relative "format_output/bullets"
require_relative "format_output/word_wrap"

require_relative "format_output/builders/bullet_builder"
require_relative "format_output/builders/column_builder"

require_relative "format_output/version"

# The format output facility. Neat columns and bullet points for all!
module FormatOutput

  # Some property variables.
  @width = 80
  @left  = 0
  @right = 0

  class << self

    # Get the full page width.
    def width(options = {})
      (options[:width] || @width).to_i
    end

    # Set the full page width.
    def width=(value)
      @width = value.to_i
    end

    # Get the working page width.
    def body(options = {})
      width(options) - (left(options) + right(options))
    end

    # Set the working page width.
    # Note always set after left and right are set.
    def body=(value)
      @width = value.to_i + @left + @right
    end

    # Get the left margin
    def left(options = {})
      (options[:left] || @left).to_i
    end

    # Set the left margin
    def left=(value)
      @left = value.to_i
    end

    # Get the left margin
    def right(options = {})
      (options[:right] || @right).to_i
    end

    # Set the right margin
    def right=(value)
      @right = value.to_i
    end

    # The left margin pad string.
    def pad(options = {})
      " " * left(options)
    end

  end

end
