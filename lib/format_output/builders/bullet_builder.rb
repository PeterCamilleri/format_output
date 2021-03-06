# coding: utf-8

# Print out bullet points.
module FormatOutput

  # A class to build bullet points for display.
  class BulletPointBuilder

    # Prepare a blank slate.
    def initialize(options)
      @body        = ::FormatOutput.width(options)
      @pad         = ::FormatOutput.pad(options)
      @bullet_data = []
      @key_length  = nil
    end

    # Add items to these bullet points.
    def add(bullet, *items)
      items.each do |item|
        @bullet_data << [bullet.to_s, item]
        bullet = ""
      end
    end

    # Render the bullet points as an array of strings.
    def render
      @key_length, results = get_key_length, []

      @bullet_data.each do |key, item|
        results.concat(render_bullet(key, item))
      end

      @bullet_data = []
      results
    end

    private

    # Allowing for a trailing space, how large is the largest bullet?
    def get_key_length
      (@bullet_data.max_by {|line| line[0].length})[0].length + 1
    end

    # Render one bullet point.
    # Returns: An array of strings, formatted as:     bullet  details
    #                                                         more details
    #                                                         more etc
    def render_bullet(key, item)
      result = []

      item.format_output_bullet_detail(width: @body - @key_length - 1, left: 0).each do |desc_line|
        result << @pad + key.ljust(@key_length) + desc_line
        key = ""
      end

      result
    end

  end

end
