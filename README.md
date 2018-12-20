# FormatOutput

The format_output gem is a CLI utility for formatting data as bullet points,
columns, or with word wrap to the console, strings, or arrays of strings.

This gem started out life buried deep within the mysh gem where it served as
the data formatting facility for that program. Such was the utility of these
methods that the long task of splitting them away from mysh was started.

Along the way, additional capabilities were added to flesh out range of
available formatting transformations. These include:

#### Columns

Neat, efficient columns of data are nice:

    0 5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95
    1 6 11 16 21 26 31 36 41 46 51 56 61 66 71 76 81 86 91 96
    2 7 12 17 22 27 32 37 42 47 52 57 62 67 72 77 82 87 92 97
    3 8 13 18 23 28 33 38 43 48 53 58 63 68 73 78 83 88 93 98
    4 9 14 19 24 29 34 39 44 49 54 59 64 69 74 79 84 89 94 99

#### Bullet Points

How about making some (bullet) points:

    Name      Wiley Coyote
    Education Super Genius
    Incident  Run over by a large truck
    Status    Flattened and accordion like.

#### Word Wrap

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

WIP

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
