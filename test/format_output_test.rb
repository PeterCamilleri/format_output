require_relative '../lib/format_output'
gem              'minitest'
require          'minitest/autorun'
require          'minitest_visible'

class FormatOutputTest < Minitest::Test

  #Track mini-test progress.
  include MinitestVisible

  def test_that_it_has_a_version_number
    refute_nil(::FormatOutput::VERSION)
    assert(::FormatOutput::VERSION.is_a?(String))
    assert(/\A\d+\.\d+\.\d+/ =~ ::FormatOutput::VERSION)
  end

end
