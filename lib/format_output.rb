# coding: utf-8

require_relative "format_output/columns"
require_relative "format_output/bullets"

require_relative "format_output/builders/bullet_builder"
require_relative "format_output/builders/column_builder"

require_relative "format_output/version"

# The format output facility. Neat columns and bullet points for all!
module FormatOutput

  @page_width = 80

  # Get the default page width.
  def self.page_width
    @page_width
  end

  # Set the default page width.
  def self.page_width=(value)
    new_width = value.to_i
    fail "Invalid page width #{new_width}." unless (20..256) === new_width
    @page_width = new_width
  end

end
