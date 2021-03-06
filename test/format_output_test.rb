require_relative '../lib/format_output'
gem              'minitest'
require          'minitest/autorun'

class FormatOutputTest < Minitest::Test

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

  def test_that_it_keeps_a_max_width
    assert_equal(80, ::FormatOutput.width)
    ::FormatOutput.width = '40'
    assert_equal(40, ::FormatOutput.width)
    assert_equal(40, ::FormatOutput.width)
    ::FormatOutput.width = 80
    assert_equal(80, ::FormatOutput.width)
  end

  def test_for_a_left_margin
    assert_equal(80, ::FormatOutput.width)
    assert_equal("", ::FormatOutput.pad)
    FormatOutput.left = 5
    assert_equal("     ", ::FormatOutput.pad)
    assert_equal(5,  ::FormatOutput.left)
    assert_equal(75, ::FormatOutput.body)

    assert_equal("     1 4\n     2 5\n     3  ",
                 [1,2,3,4,5].format_output_columns(width: 10))

  ensure
    FormatOutput.left = 0
  end

  # Formatting tests imported from the mysh gem.
  def test_some_formatting
    assert_equal("1 4\n2 5\n3  ",
                 [1,2,3,4,5].format_output_columns(width: 5))

    assert_equal(["1 4", "2 5", "3  "],
                 [1,2,3,4,5].format_output_raw_columns(width: 5))

    assert_equal("* 1\n* 2\n* 3\n* 4\n* 5",
                 [1,2,3,4,5].format_output_bullets(width: 5))

    assert_equal(["* 1", "* 2", "* 3", "* 4", "* 5"],
                 [1,2,3,4,5].format_output_raw_bullets(width: 5))

    data =
      [["key_largo", "/long_folder_name_one/long_folder_name_two/long_folder_name_three/fine_descriptive_name"],
       ["key_west",  "Semper ubi sub ubi. Semper ubi sub ubi. Semper ubi sub ubi. Semper ubi sub ubi. "],
       ["counting",  Array.new(100) {|i| i} ],
       ["pie", Math::PI]
      ]

    result =
       "key_largo /long_folder_name_one/long_folder_name_two/long_folder_name_three/fin\n" +
       "          e_descriptive_name\n" +
       "key_west  Semper ubi sub ubi. Semper ubi sub ubi. Semper ubi sub ubi. Semper\n" +
       "          ubi sub ubi.\n" +
       "counting  0 5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95\n" +
       "          1 6 11 16 21 26 31 36 41 46 51 56 61 66 71 76 81 86 91 96\n" +
       "          2 7 12 17 22 27 32 37 42 47 52 57 62 67 72 77 82 87 92 97\n" +
       "          3 8 13 18 23 28 33 38 43 48 53 58 63 68 73 78 83 88 93 98\n" +
       "          4 9 14 19 24 29 34 39 44 49 54 59 64 69 74 79 84 89 94 99\n" +
       "pie       3.141592653589793"

    assert_equal(result, data.format_output_bullets)

    data = [["Name", "Wiley Coyote"],
            ["Education", "Super Genius"],
            ["Incident", "Run over by a large truck"],
            ["Status", "Flattened and accordion like."]
           ]
    result = "Name      Wiley Coyote\n" +
             "Education Super Genius\n" +
             "Incident  Run over by a large truck\n" +
             "Status    Flattened and accordion like."

    assert_equal(result, data.format_output_bullets(width: 60))

    text = "This is a very very very long and verbose massage from the Swedish Prime Minister"

    result = "This is a very very very long and verbose massage from the Swedish Prime\nMinister"
    assert_equal(result, text.format_output_word_wrap)

    result = "This is a very very very long and\nverbose massage from the Swedish Prime\nMinister"
    assert_equal(result, text.format_output_word_wrap(width: 40))

    result = "     This is a very very very long and\n     verbose massage from the Swedish Prime\n     Minister"
    assert_equal(result, text.format_output_word_wrap(width: 40, left: 5))
  end

  def test_a_wrapped_array
    ary = ["There are many many stars in the heavens. Lots really. Like billions and billions",
           "There are many many fishies in the sea.  Lots really. Like billions and billions",
           "There are many many birds in the sky.  Lots really. Like billions and billions"]

    result = "     There are many many stars in the\n" +
             "     heavens. Lots really. Like billions and\n" +
             "     billions\n" +
             "\n" +
             "     There are many many fishies in the sea.\n" +
             "     Lots really. Like billions and billions\n" +
             "\n" +
             "     There are many many birds in the sky.\n" +
             "     Lots really. Like billions and billions\n"

    assert_equal(result, ary.format_output_word_wrap(width: 40, left: 5))
  end

end
