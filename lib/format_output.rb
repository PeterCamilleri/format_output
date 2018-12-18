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
  @page_width   = 80
  @left_margin  = 0
  @right_margin = 0
  @min_width    = 20

  class << self

    attr_reader   :page_width
    attr_accessor :left_margin
    attr_accessor :right_margin
    attr_accessor :min_width

    # Get the default working page width.
    def width
      @page_width - (@left_margin + @right_margin)
    end

    # Set the default page width.
    def page_width=(value)
      new_width = value.to_i

      if (new_width - @min_width) < (@left_margin + @right_margin)
        fail "Invalid page width #{new_width}."
      end

      @page_width = new_width
    end

  end

end
