# FormatOutput

The format_output gem is used to facilitate the creation of CLI programs in
Ruby by formatting data as bullet points, columns, or word wrap to the console,
strings, or arrays of strings.

This gem started out life buried deep within the mysh gem where it served as
the data formatting facility for that program. Such was the usefulness of these
methods that the long task of splitting them away from mysh was started.

Along the way, additional capabilities were added to flesh out range of
available formatting transformations. The following  are taken from the
format_output unit test suite and include:

### Columns

Neat, efficient columns of data are nice:

    0 5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95
    1 6 11 16 21 26 31 36 41 46 51 56 61 66 71 76 81 86 91 96
    2 7 12 17 22 27 32 37 42 47 52 57 62 67 72 77 82 87 92 97
    3 8 13 18 23 28 33 38 43 48 53 58 63 68 73 78 83 88 93 98
    4 9 14 19 24 29 34 39 44 49 54 59 64 69 74 79 84 89 94 99

### Bullet Points

How about making some (bullet) points:

    Name      Wiley Coyote
    Education Super Genius
    Incident  Run over by a large truck
    Status    Flattened and accordion like

### Word Wrap

Well long text can be hard to (word) wrap your head around:

    There are many many stars in the
    heavens. Lots really. Like billions and
    billions

    There are many many fishies in the sea.
    Lots really. Like billions and billions

    There are many many birds in the sky.
    Lots really. Like billions and billions


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'format_output'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install format_output

## Usage

### Formatting Control Parameters

The formatting of output is controlled by four parameters. These are:

Parameter| Description                                                       | Default
---------|-------------------------------------------------------------------|-----------
width    |The overall width of the output "stage".                           | 80
left     |The size of the left margin. White space to the left of the data.  | 0
body     |The center of the "stage" where the formatted data resides.        | 80
right    |The size of the right margin. White space to the right of the data.| 0

These relationships are illustrated below:

    |<-------------------------- width --------------------------->|
    |<left  margin>|<------------ body ------------>|<right margin>|
                     1  4  7  10  13  16  19  22  25
                     2  5  8  11  14  17  20  23
                     3  6  9  12  15  18  21  24

      width = 60
      left  = 14
      right = 14
      body  = 32

In many cases however, the programmer will not need to modify these parameters.
That is the defaults values provided are suitable for most application.

If the defaults are not suitable, there are two approaches that are available:

1. The global parameters can be changed. For example:

    FormatOutput.width = 132

2. The parameters can be set for one call only. For example:

    my_array.format_output_columns(left: 5, right: 5)


Note: The format_output parameters are connected in that they define the same
formatting work area. As a result, the following interactions occur:

    FormatOutput.left            # Gets the left margin
    FormatOutput.left  = value   # Sets the left margin
    FormatOutput.right           # Gets the left margin
    FormatOutput.right = value   # Sets the left margin
    FormatOutput.width           # Gets the full width
    FormatOutput.width = value   # Sets the full width
    FormatOutput.body            # Gets width - (left + right)
    FormatOutput.width = value   # Sets width = value + left + right

As can be seen, setting the body and setting the other parameters does interact
quite a bit. So these rules should be followed:

* Always set left and right margins before setting the body. Otherwise, the
body setting will be modified to a value other than the set value.
* Don't set both the body and the width or unexpected results may be observed.

When parameters are passed in for individual calls, they take effect at the
same time so the ordering is not significant. Still, setting body and width
will have unpredictable results.

### API Levels

Each of the three types of formatting has three levels of support. These are
summarized as follows:

Columns                   | Word Wrap                  | Bullet Points            | Returns
--------------------------|----------------------------|--------------------------|----------------
puts_format_output_columns|puts_format_output_word_wrap|puts_format_output_bullets| nil
format_output_columns     |format_output_word_wrap     |format_output_bullets     | a string
format_output_raw_columns |format_output_raw_word_wrap |format_output_raw_bullets | [strings]

The puts_etc methods return nil because they directly print the results of the
formatting using the puts method. The intermediate methods return a string,
replete with any needed new line characters. Finally the "raw" methods return
an array of strings in place of said new line sequences.

Regardless of how output of the results is achieved, the formatting done is the
same for all three levels. The next sections focus on that formatting.

### Columns

The column format is used to display data in neat columns. Yes sure, you can
just do a puts on an array of data and it will blast it to the console, one
item per line, but that can be a lot off lines scrolling meaninglessly off the
screen.

Column formatting tries to use as few lines of output as it can. For example:

```ruby
# Some simple number, squared, and cubed columns
column_data = Array.new(25) { |i| "#{i}, #{i*i}, #{i*i*i}  " }
puts "Numbers, squares, and cubes.", ""
column_data.puts_format_output_columns(width: 72)
```

The output is:

    Numbers, squares, and cubes.

    0, 0, 0      7, 49, 343      14, 196, 2744   21, 441, 9261
    1, 1, 1      8, 64, 512      15, 225, 3375   22, 484, 10648
    2, 4, 8      9, 81, 729      16, 256, 4096   23, 529, 12167
    3, 9, 27     10, 100, 1000   17, 289, 4913   24, 576, 13824
    4, 16, 64    11, 121, 1331   18, 324, 5832
    5, 25, 125   12, 144, 1728   19, 361, 6859
    6, 36, 216   13, 169, 2197   20, 400, 8000

Now this is not meant to be optimal, but to instead show how neat columns are
created even with items of varying length.

### Word Wrap

The word wrap format is used to take very long lines of text and convert it
into a number of shorter lines. The trick is to avoid splitting words and
making the text hard to read.

```ruby
# Maybe (word) wrap your head around a little Shakespear?
long_text = "Wherefore rejoice? What conquest brings he home? What tributaries follow him to Rome, to grace in captive bonds his chariot-wheels? You blocks, you stones, you worse than senseless things!"
puts "", "", "Word wrapping the Great Bard!", ""
long_text.puts_format_output_word_wrap(width: 72)
```

The output is:

    Word wrapping the Great Bard!

    Wherefore rejoice? What conquest brings he home? What tributaries
    follow him to Rome, to grace in captive bonds his chariot-wheels? You
    blocks, you stones, you worse than senseless things!

Now, if the input is an array of really long strings, the word wrapper will
convert each of those lines into a neatly word wrapped paragraph with a blank
line between them.

### Bullet Points

The bullet point formatter is used to create an output consisting of one or
more bullet points. So how is a bullet point defined? There are two essential
components, illustrated here:

    tag1 detail1
    tag2 detail2
    tag3 etc etc etc

So what is the input? An array of bullet point data of course! That is an array
of arrays. The following array describes the sample bullet point above:

```ruby
datum = [["tag1", "detail1"],["tag2", "detail2"],["tag3", "etc etc etc"]]
datum.puts_format_output_bullets
```

Now, this array contained in the outer array describes the actual bullet points
that are created. This inner array may contain zero or more elelemts.

#### Zero Elements and Empty Bullets

When an empty array is used, the bullet formatter skips that entry. This can be
useful when gathering data for a report and for one item no data is found.
There are three ways to create an empty bullet point:

```ruby
[]
["zero", []]
["zero", nil]
```

Note that the following, is not fully empty

```ruby
["zero", ""]
```

Yields a bullet point with a bullet of "zero" and no detail text.

#### One Element

When an array with one element is used, that element becomes the detail and the
default bullet ("*") is used:

```ruby
["one with a (default) bullet."]
```

produces:

    *     one with a (default) bullet.

#### Two Elements

When an array with two elements is used, the first is the bullet and the second
is the detail. This is by far the most common:

```ruby
["two", 2],
```

produces:

    two   2


#### Three or more Elements

When an array with three or more elements is used, the first is the bullet and
the second is the detail. The rest of the elements are additional details for
this bullet point. Like this:

````ruby
["three", 3, "more than two", "more than one", "more than zero"],
```

produces:

    three 3
          more than two
          more than one
          more than zero

#### The Details

Now we can turn our attention to the actual details and to a lesser extent, the
tags. These can be:

1. A String
2. An object that responds favorably to the to_s method.

In addition, the details may be an Array.

So when the details are a string that string is used as the details. And yes,
if the string is too long to fit, it gets word wrapped! Like this:

```ruby
['five', "I can see for miles and miles and more miles and yet more miles and a lot of miles and damn more miles"]
```

produces:

    five  I can see for miles and miles and more miles and yet more miles
          and a lot of miles and damn more miles

Note, this courtesy does not extend to the bullet tags. They must exhibit a
sensible level of brevity!

Further, when the details are contained in there own little array, they are
displayed in columns if they don't fit in one line. Look here:

```ruby
["four", (1..100).to_a]
```

produces:

    four  1 6  11 16 21 26 31 36 41 46 51 56 61 66 71 76 81 86 91 96
          2 7  12 17 22 27 32 37 42 47 52 57 62 67 72 77 82 87 92 97
          3 8  13 18 23 28 33 38 43 48 53 58 63 68 73 78 83 88 93 98
          4 9  14 19 24 29 34 39 44 49 54 59 64 69 74 79 84 89 94 99
          5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

OR...

* Make a suggestion by raising an
 [issue](https://github.com/PeterCamilleri/format_output/issues)
. All ideas and comments are welcome.

## License

The gem is available as open source under the terms of the
[MIT License](./LICENSE.txt).

## Code of Conduct

Everyone interacting in the format_output project’s codebases, issue trackers,
chat rooms and mailing lists is expected to follow the
[code of conduct](./CODE_OF_CONDUCT.md).
