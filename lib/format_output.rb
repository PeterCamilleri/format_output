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
  @min   = 20

  class << self

    attr_writer   :width
    attr_writer   :left
    attr_writer   :right
    attr_accessor :min

    # Get the full page width.
    def width(options = {})
      options[:width] || @width
    end

    # Get the working page width.
    def body(options = {})
      width(options) - (left(options) + right(options))
    end

    # Get the left margin
    def left(options = {})
      (options[:left] || @left).to_i
    end

    # Get the left margin
    def right(options = {})
      (options[:right] || @right).to_i
    end

    # The left margin pad string.
    def pad(options = {})
      " " * left(options)
    end

    # Are these options valid?
    def validate(options = {})
      fail "Invalid format settings." if body(options) < @min
    end

  end

end
