require_relative '../lib/format_output'
gem              'minitest'
require          'minitest/autorun'
require          'minitest_visible'

class FormatOutputTest < Minitest::Test

  #Track mini-test progress.
  include MinitestVisible

  def test_that_it_has_a_version_number
    refute_nil(::FormatOutput::VERSION)
    assert(::FormatOutput::VERSION.frozen?)
    assert(::FormatOutput::VERSION.is_a?(String))
    assert(/\A\d+\.\d+\.\d+/ =~ ::FormatOutput::VERSION)
  end

  def test_that_it_has_a_description
    refute_nil(::FormatOutput::DESCRIPTION)
    assert(::FormatOutput::DESCRIPTION.frozen?)
    assert(::FormatOutput::DESCRIPTION.is_a?(String))
  end

  def test_that_it_has_an_other_stuff_too
    refute_nil(::FormatOutput::BulletPointBuilder)
    refute_nil(::FormatOutput::ColumnBuilder)
  end

  def test_that_keeps_a_page_width
    assert_equal(80, FormatOutput.page_width)
    FormatOutput.page_width = '40'
    assert_equal(40, FormatOutput.page_width)
    assert_raises {FormatOutput.page_width = 2}
    assert_raises {FormatOutput.page_width = 'apple'}
    assert_equal(40, FormatOutput.page_width)
    FormatOutput.page_width = 80
    assert_equal(80, FormatOutput.page_width)
  end

end
